updateBadge = ()->
  filterType = localStorage.defaultFilter || 'assigned'
  window.githubClient.issues({filter: filterType, state: 'open'}).done((data)->
    num = data.length
    if num > 0
      chrome.browserAction.setBadgeText({text: String(num)})
      chrome.browserAction.setBadgeBackgroundColor({color: [255, 0, 0, 200]})
    else
      chrome.browserAction.setBadgeText({text: ""})
  )

$ ()->
  pollInterval = 60 * 1000

  updateBadge()

  timerId = setInterval(updateBadge, pollInterval)

chrome.runtime.onMessage.addListener (request, sender, sendResponse)->
  if request.from == "options"
    if request.subject == "updateBadge"
      updateBadge()
      sendResponse {message: 'success'}
