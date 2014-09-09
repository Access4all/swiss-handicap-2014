class ColorblindnessViewModel
  constructor: ->
    @toOccupyCount = ko.observable(0)

    $('td.occupied').click ->
      alert 'Dieser Termin ist schon besetzt!'

    $('td.not_available').click ->
      alert 'Dieser Termin ist nicht verfügbar!'

    $('td:not(.occupied, .not_available)').click (e) =>
      $target = $(e.target)
      if $target.parent().find('.to_occupy').length == 0
        $target.addClass('to_occupy')
        @toOccupyCount(@toOccupyCount() + 1)

        console.log @toOccupyCount()
        if @toOccupyCount() == 5
          $('body').removeClass('grayscale')
      else
        alert 'Bitte nur einen Termin pro Tag anwählen!'

$ ->
  $('body.colorblindness').each ->
    ko.applyBindings new ColorblindnessViewModel

  $('#task_colorblindness').on 'shown.bs.modal', (e) ->
    $('body').addClass('grayscale')