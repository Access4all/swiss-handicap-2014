class ColorblindnessViewModel
  constructor: ->
    $('td.occupied').click ->
      alert 'Dieser Termin ist schon besetzt!'

    $('td.not_available').click ->
      alert 'Dieser Termin ist nicht verfügbar!'

    $('td:not(.occupied, .not_available)').click (e) ->
      $(e.target).toggleClass('to_occupy')

    @playAudio = ->
      @play()

$ ->
  $('body.colorblindness').each ->
    ko.applyBindings new ColorblindnessViewModel

  $('#task_colorblindness').on 'shown.bs.modal', (e) ->
    setTimeout (->
      $('body').addClass('grayscale')
    ), 2000