window.githubClient = {
  get: (url, options)->
    data = $.extend({}, options)
    return $.ajax {
      url: url,
      data: data,
      type: 'GET',
      headers: {
        'Authorization': 'token ' + localStorage.accessToken
      }
    }
  issues: (options)->
    githubClient.get (localStorage.endPoint || 'https://api.github.com/') + 'issues', $.extend({filter: 'assigned', state: 'open'}, options)
}
