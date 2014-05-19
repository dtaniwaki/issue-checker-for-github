window.addEventListener("DOMContentLoaded", function() {
  var $list = $('#list');
  $list.html('');
  window.githubClient.issues({filter: 'assigned', state: 'open'}).done(function(data){
    $.each(data, function(idx){
      var $repo = $('#repo_' + this.repository.id, $list);
      if ($repo.length == 0) {
        $repo = $('<li id="repo_' + this.repository.id + '"><ul class="issues"></ul></li>');
        $('<h3><a href="' + this.repository.html_url + '">' + this.repository.owner.login + ' / ' + this.repository.name + '</a></h3>').prependTo($repo);
        $repo.appendTo($list);
      }
      var $li = $('<li class="issue">');
      $li.append('<a href="' + this.html_url + '" title="' + this.body + '">' + this.title + '</a>');
      $('ul', $repo).append($li);
    });
  }).fail(function(jqXHR, textStatus){
    $list.html('Please set a valid access token.');
    chrome.tabs.create({url: '/options.html'});
  });
});

$(function(){
  var close = function(e) {
    e.preventDefault();
    window.close();
  }
  $('#close_button').on('click', close);

  $(function() {
    $(document).on('click', 'a', function(e) {
      chrome.tabs.create({url: $(this).attr('href')});
    });
  });
});
