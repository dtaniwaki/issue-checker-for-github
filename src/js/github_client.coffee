window.githubClient = {
  issues: ()->
    data = {
      access_token: localStorage.accessToken,
      filter: 'assigned',
      state: 'open'
    }
    return $.ajax {
      url: 'https://api.github.com/issues',
      data: data,
      type: 'GET'
    }
}
