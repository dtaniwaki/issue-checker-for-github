window.githubClient = {
  issues: (options)->
    data = $.extend({filter: 'assigned', state: 'open'}, options)
    data.access_token = localStorage.accessToken
    return $.ajax {
      url: (localStorage.endPoint || 'https://api.github.com/') + 'issues',
      data: data,
      type: 'GET'
    }
}
