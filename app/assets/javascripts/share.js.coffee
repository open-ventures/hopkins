$(document).ready ->

  SetCoordinates = (c) ->
    $('#imgX1').val c.x
    $('#imgY1').val c.y
    $('#imgWidth').val c.w
    $('#imgHeight').val c.h
    $('#btnOk').show()


  $(document).on 'change', '#share-photo-file', ->
    $('#cropModal').modal('show')
    $( ".modal-body" ).empty()
    $( ".modal-body" ).append("<img id='Image1' src='' alt='' style='display: none' />")
    $( ".modal-body" ).append("<canvas id='canvas' height='100' width='100' style='display: none'></canvas>")
    $('#Image1').hide()
    $('#btnOk').hide()
    reader = new FileReader

    reader.onload = (e) ->
      $('#Image1').show()
      $('#Image1').attr 'src', e.target.result
      $('#Image1').Jcrop
        boxWidth: 400
        boxHeight: 400
        aspectRatio: 1
        onChange: SetCoordinates
        onSelect: SetCoordinates

    reader.readAsDataURL $(this)[0].files[0]


  $('#btnOk').click ->
    x1 = $('#imgX1').val()
    y1 = $('#imgY1').val()
    width = $('#imgWidth').val()
    height = $('#imgHeight').val()
    canvas = $('#canvas')[0]
    context = canvas.getContext('2d')
    img = new Image()
    img.src = $('#Image1').attr('src')
    img.onload = ->
      canvas.height = height
      canvas.width = width
      context.drawImage img, x1, y1, width, height, 0, 0, width, height
      dataUrl = canvas.toDataURL()
      $('#imgCropped').val dataUrl

      if $('#imgCropped').val() isnt '' and $('#share_name').val() isnt ''
        $('#cropModal').modal('hide')
        $('#share-form-submitter').click()
      else
        $('#cropModal').modal('hide')

  if $('.share-form').length
    $('.share-form input').change ->
      if $('#imgCropped').val() isnt '' and $('#share_name').val() isnt ''
        $('#share-form-submitter').click()

