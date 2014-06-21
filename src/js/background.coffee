updateBadge = (num)->
  if num > 0
    chrome.browserAction.setBadgeText {text: String(num)}
    chrome.browserAction.setBadgeBackgroundColor {color: [255, 0, 0, 200]}
  else
    chrome.browserAction.setBadgeText {text: ""}

notify = (data)->
  items = []
  lastUpdated = moment localStorage.lastUpdated ? [1970, 1, 1]
  $.each data, (idx)->
    t = moment this.created_at
    if lastUpdated.valueOf() < t.valueOf()
      items.push {title: this.title, message: ''}

  if items.length > 5
    items = items.slice(1, 5)
    items.push {title: ' and more...', message: ''}

  chrome.notifications.create 'github-checker', {
    type: "list",
    title: "Github Checker Notification",
    message: "You got new issues!",
    iconUrl: "images/icon48.png",
    items: items,
    isClickable: true
  }, (notificationId)->


syncIssues = (data)->
  filterType = localStorage.defaultFilter || 'assigned'
  now = moment()

  if data?
    updateBadge(data.length)

    localStorage.lastUpdated = now
  else
    window.githubClient.issues({filter: filterType, state: 'open'}).done (data)->
      updateBadge(data.length)

      if localStorage.notification == 'yes'
        notify(data)

      localStorage.lastUpdated = now

$ ()->
  pollInterval = 60 * 1000

  syncIssues()

  timerId = setInterval(syncIssues, pollInterval)

chrome.runtime.onMessage.addListener (request, sender, sendResponse)->
  if request.subject == "updateBadge"
    syncIssues(request.message)

    sendResponse {message: 'success'}
