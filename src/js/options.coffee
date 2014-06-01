$(()->
  $('#access_token').val(localStorage.accessToken)
 
  $('#save_btn').click((e)->
    e.preventDefault()

    localStorage.accessToken = $('#access_token').val()

    alert('Options have been saved successfully.')
  )
)
