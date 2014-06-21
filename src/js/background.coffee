updateBadge = (num)->
  if num > 0
    chrome.browserAction.setBadgeText {text: String(num)}
    chrome.browserAction.setBadgeBackgroundColor {color: [255, 0, 0, 200]}
  else
    chrome.browserAction.setBadgeText {text: ""}

notify = (data, callback)->
  items = []
  try
    lastIssues = JSON.parse localStorage.lastIssues
  catch
    lastIssues = []
  $.each data, (idx, d)->
    if lastIssues.indexOf(d.number) == -1
      items.push {title: d.title, message: ''}

  if items.length > 5
    items = items.slice(0, 4)
    items.push {title: ' and more...', message: ''}

  chrome.notifications.clear 'github-checker', ()->

  chrome.notifications.create 'github-checker', {
    type: "list",
    title: "Github Checker Notification",
    message: "You got new issues!",
    iconUrl: "images/icon48.png",
    items: items,
    isClickable: true
  }, (notificationId)->
    callback?()

syncIssues = (data)->
  filterType = localStorage.defaultFilter || 'assigned'

  if data?
    updateBadge(data.length)

    localStorage.lastIssues = JSON.stringify $.map data, (d, idx)->
      d.number
  else
    window.githubClient.issues({filter: filterType, state: 'open'}).done (data)->
      updateBadge(data.length)

      if localStorage.notification == 'yes'
        notify data, ()->
          localStorage.lastIssues = JSON.stringify $.map data, (d, idx)->
            d.number

$ ()->
  pollInterval = 60 * 1000

  syncIssues()

  timerId = setInterval(syncIssues, pollInterval)

chrome.runtime.onMessage.addListener (request, sender, sendResponse)->
  if request.subject == "updateBadge"
    syncIssues(request.message)

    sendResponse {message: 'success'}
