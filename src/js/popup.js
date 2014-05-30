window.addEventListener("DOMContentLoaded", function() {
  var $list = $('#list');
  $list.html('').addClass('loading');
  window.githubClient.issues({filter: 'assigned', state: 'open'}).done(function(data){
    $.each(data, function(idx){
      var $repo = $('#repo_' + this.repository.id, $list);
      if ($repo.length == 0) {
        $repo = $('<li id="repo_' + this.repository.id + '" class="repo"><ul class="issues"></ul></li>');
        $('<h3 class="title"><a href="' + this.repository.html_url + '">' + this.repository.owner.login + ' / ' + this.repository.name + '</a></h3>').prependTo($repo);
        $repo.appendTo($list);
      }
      var $li = $('<li class="issue">');
      $li.append('<a href="' + this.html_url + '" title="' + this.body + '" class="title">' + this.title + '</a>');
      $('ul', $repo).append($li);
    });
  }).fail(function(jqXHR, textStatus){
    $list.html('Please set a valid access token.');
    chrome.tabs.create({url: '/options.html'});
  }).always(function(){
    $list.removeClass('loading');
  });
});

$(function(){
  var close = function(e) {
    e.preventDefault();
    window.close();
  }
  $('#close_button').on('click', close);

  $(function() {
    $(document).on('click', 'a:not([data-no-link])', function(e) {
      chrome.tabs.create({url: $(this).attr('href')});
    });
  });
});
