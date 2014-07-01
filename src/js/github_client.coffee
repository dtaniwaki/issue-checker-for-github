window.githubClient = {
  get: (url, options)->
    data = $.extend({}, options)
    data.access_token = localStorage.accessToken
    return $.ajax {
      url: url,
      data: data,
      type: 'GET'
    }
  issues: (options)->
    githubClient.get (localStorage.endPoint || 'https://api.github.com/') + 'issues', $.extend({filter: 'assigned', state: 'open'}, options)
}
