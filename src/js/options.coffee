$ ()->
  $('#access_token').val(localStorage.accessToken)
  $('#end_point').val(localStorage.endPoint)
  $('#show_labels_' + (localStorage.showLabels || 'yes')).prop('checked', true)
  $('#notification_' + (localStorage.notification || 'yes')).prop('checked', true)
  $('#default_filter_' + (localStorage.defaultFilter || 'assigned')).prop('checked', true)
 
  $('#save_btn').click((e)->
    e.preventDefault()

    localStorage.accessToken = $('#access_token').val()
    endPoint = $('#end_point').val()
    if !!endPoint
      endPoint = endPoint.replace(/\/*$/, '\/')
    localStorage.endPoint = endPoint || ''
    localStorage.showLabels = String($('input[name=show_labels]:checked').val())
    localStorage.notification = String($('input[name=notification]:checked').val())
    localStorage.defaultFilter = String($('input[name=default_filter]:checked').val())

    chrome.runtime.sendMessage {
      from: "options", subject: "updateBadge"
    }, ()-> {}

    alert('Options have been saved successfully.')
  )
