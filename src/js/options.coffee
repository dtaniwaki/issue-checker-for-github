$(()->
  $('#access_token').val(localStorage.accessToken)
  $('#show_labels').prop('checked', localStorage.showLabels == 'true')
 
  $('#save_btn').click((e)->
    e.preventDefault()

    localStorage.accessToken = $('#access_token').val()
    localStorage.showLabels = String($('#show_labels').prop('checked'))

    alert('Options have been saved successfully.')
  )
)
