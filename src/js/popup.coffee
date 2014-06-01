window.addEventListener "DOMContentLoaded", ()->
  $list = $('#list')
  $list.html('').addClass('loading')
  window.githubClient.issues({filter: 'assigned', state: 'open'}).done((data)->
    $.each data, (idx)->
      $repo = $('#repo_' + this.repository.id, $list)
      if $repo.length == 0
        $repo = $('<li id="repo_' + this.repository.id + '" class="repo"><ul class="issues"></ul></li>')
        $('<h3 class="title"><a href="' + this.repository.html_url + '">' + this.repository.owner.login + ' / ' + this.repository.name + '</a></h3>').prependTo($repo)
        $repo.appendTo($list)
      $li = $('<li class="issue">')
      $li.append('<a href="' + this.html_url + '" title="' + this.body + '" class="title">' + this.title + '</a>')
      $('ul', $repo).append($li)
  ).fail((jqXHR, textStatus)->
    $list.html('Please set a valid access token.')
    chrome.tabs.create({url: '/options.html'})
  ).always(()->
    $list.removeClass('loading')
  )

$(()->
  $('#close_button').on 'click', (e)->
    e.preventDefault();
    window.close();

  $(document).on 'click', 'a:not([data-no-link])', (e)->
    chrome.tabs.create({url: $(this).attr('href')});
)
