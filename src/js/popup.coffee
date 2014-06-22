loadingPage = (flag)->
  $list = $('#list')
  if flag
    $list.html('')
    $list.addClass('loading')
  else
    $list.removeClass('loading')

updatePage = (data)->
  $list = $('#list')
  $list.html('')
  $.each data, (idx, issue)->
    $repo = $('#repo_' + issue.repository.id, $list)
    if $repo.length == 0
      $repo = $('<li id="repo_' + issue.repository.id + '" class="repo"><ul class="issues"></ul></li>')
      $('<h3 class="repo-title"><span class="octicon octicon-repo"></span><a href="' + issue.repository.html_url + '">' + issue.repository.owner.login + ' / ' + issue.repository.name + '</a></h3>').prependTo($repo)
      $repo.appendTo($list)
    $li = $('<li class="issue">')
    $title = $('<span class="issue-title">').appendTo($li)
    link = '<span class="octicon octicon-issue-opened"></span>'
    link += '<a href="' + issue.html_url + '">' + issue.title + '</a>'
    if localStorage.showLabels == 'yes'
      $.each issue.labels, (idx, label)->
        link += '<span class="label" style="background-color: #' + label.color + '">' + label.name + '</span>'
    $title.append(link)
    $('ul', $repo).append($li)

failurePage = (jqXHR, textStatus)->
  $list = $('#list')
  $list.html('Please set a valid access token.')
  chrome.tabs.create({url: '/options.html'})

loadIssues = (filterType)->
  $('#tabs [data-filter-type]').removeClass('selected')
  $('#tabs [data-filter-type=' + filterType + ']').addClass('selected')
  loadingPage(true)
  window.githubClient.issues({filter: filterType}).done (data)->
    updatePage(data)
    if filterType == (localStorage.defaultFilter || 'assigned')
      chrome.runtime.sendMessage {
        from: "popup", subject: "updateBadge", message: data
      }, ()-> {}
  .fail(failurePage).always ()->
    loadingPage(false)

window.addEventListener "DOMContentLoaded", ()->
  loadIssues localStorage.defaultFilter || 'assigned'

$ ()->
  $('#close_button').on 'click', (e)->
    e.preventDefault()
    window.close()

  $tabs = $('#tabs [data-filter-type]')
  $tabs.each (idx, tab)->
    $(tab).click (e)->
      e.preventDefault()
      loadIssues $(this).data('filter-type')

  $(document).on 'click', 'a:not([data-no-link])', (e)->
    e.preventDefault()
    href = $(this).attr('href')
    if href[0] != '#'
      chrome.tabs.create({url: href})
