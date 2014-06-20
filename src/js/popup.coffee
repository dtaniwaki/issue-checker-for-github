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
  $.each data, (idx)->
    $repo = $('#repo_' + this.repository.id, $list)
    if $repo.length == 0
      $repo = $('<li id="repo_' + this.repository.id + '" class="repo"><ul class="issues"></ul></li>')
      $('<h3 class="repo-title"><a href="' + this.repository.html_url + '">' + this.repository.owner.login + ' / ' + this.repository.name + '</a></h3>').prependTo($repo)
      $repo.appendTo($list)
    $li = $('<li class="issue">')
    link = ''
    link += '<a href="' + this.html_url + '" class="issue-title">' + this.title + '</a>'
    if localStorage.showLabels == 'true'
      $.each this.labels, (idx)->
        link += '<span class="label item" style="background-color: #' + this.color + '">' + this.name + '</span>'
    $li.append(link)
    $('ul', $repo).append($li)

failurePage = (jqXHR, textStatus)->
  $list = $('#list')
  $list.html('Please set a valid access token.')
  chrome.tabs.create({url: '/options.html'})

window.addEventListener "DOMContentLoaded", ()->
  filterType = localStorage.defaultFilter || 'assigned'
  $('#tabs [data-filter-type]').removeClass('selected')
  $('#tabs [data-filter-type=' + filterType + ']').addClass('selected')
  loadingPage(true)
  window.githubClient.issues({filter: filterType}).done(updatePage).fail(failurePage).always(()->
    loadingPage(false)
  )

$ ()->
  $('#close_button').on 'click', (e)->
    e.preventDefault()
    window.close()

  $tabs = $('#tabs [data-filter-type]')
  $tabs.each (idx)->
    $(this).click (e)->
      e.preventDefault()
      $tab = $(this)
      filterType = $tab.data('filter-type')

      $tabs.removeClass('selected')
      $tab.addClass('selected')
      loadingPage(true)
      window.githubClient.issues({filter: filterType}).done(updatePage).fail(failurePage).always(()->
        loadingPage(false)
      )

  $(document).on 'click', 'a:not([data-no-link])', (e)->
    e.preventDefault()
    href = $(this).attr('href')
    if href[0] != '#'
      chrome.tabs.create({url: href})
