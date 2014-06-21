$ ()->
  $('#access_token').val(localStorage.accessToken)
  $('#show_labels').prop('checked', localStorage.showLabels == 'true')
  $('#notification_' + (localStorage.notification || 'yes')).prop('checked', true)
  $('#default_filter_' + (localStorage.defaultFilter || 'assigned')).prop('checked', true)
 
  $('#save_btn').click((e)->
    e.preventDefault()

    localStorage.accessToken = $('#access_token').val()
    localStorage.showLabels = String($('#show_labels').prop('checked'))
    localStorage.notification = String($('input[name=notification]:checked').val())
    localStorage.defaultFilter = String($('input[name=default_filter]:checked').val())

    chrome.runtime.sendMessage {
      from: "options", subject: "updateBadge"
    }, ()-> {}

    alert('Options have been saved successfully.')
  )
