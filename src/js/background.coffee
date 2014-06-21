updateBadge = (data)->
  num = data.length
  if num > 0
    chrome.browserAction.setBadgeText {text: String(num)}
    chrome.browserAction.setBadgeBackgroundColor {color: [255, 0, 0, 200]}
  else
    chrome.browserAction.setBadgeText {text: ""}

  now = moment()

  if localStorage.notification == 'yes'
    items = []
    lastNotifiedTime = moment localStorage.lastNotifiedTime ? [1970, 1, 1]
    $.each data, (idx)->
      t = moment this.created_at
      if lastNotifiedTime.valueOf() < t.valueOf()
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

  localStorage.lastNotifiedTime = now

syncIssues = ()->
  filterType = localStorage.defaultFilter || 'assigned'
  window.githubClient.issues({filter: filterType, state: 'open'}).done updateBadge

$ ()->
  pollInterval = 60 * 1000

  syncIssues()

  timerId = setInterval(syncIssues, pollInterval)

chrome.runtime.onMessage.addListener (request, sender, sendResponse)->
  if request.subject == "updateBadge"
    if request.message
      updateBadge(request.message)
    else
      syncIssues()
    sendResponse {message: 'success'}
