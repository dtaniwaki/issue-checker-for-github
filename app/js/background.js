$(function(){
  var pollInterval = 60 * 1000;
  var timerId;

  var updateBadge = function() {
    window.githubClient.issues({filter: 'assigned', state: 'open'}).done(function(data){
      var num = data.length;
      if (num > 0) {
        chrome.browserAction.setBadgeText({text: String(num)})
        chrome.browserAction.setBadgeBackgroundColor({color: [255, 0, 0, 200]})
      } else {
        chrome.browserAction.setBadgeText({text: ""})
      }
    });
  };
  updateBadge();
  timerId = setInterval(updateBadge, pollInterval);
});
