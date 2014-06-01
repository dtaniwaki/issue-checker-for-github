window.githubClient = {
  issues: ()->
    return $.ajax {
      url: 'https://api.github.com/issues',
      data: {
        access_token: localStorage.accessToken,
        filter: 'assigned',
        state: 'open'
      },
      type: 'GET'
    }
}
