class ColorblindnessViewModel
  constructor: ->
    @toOccupyCount = ko.observable(0)

    $('td').click (e) =>
      $(e.target).removeClass('grayscale')

    $('td:not(.occupied, .not_available)').click (e) =>
      $target = $(e.target)
      if $target.parent().find('.to_occupy').length == 0
        $target.addClass('to_occupy')
        @toOccupyCount(@toOccupyCount() + 1)

        if @toOccupyCount() == 5
          $('.grayscale').removeClass('grayscale')

$ ->
  $('body.colorblindness').each ->
    ko.applyBindings new ColorblindnessViewModel

  $('#colorblindness_simulation').on 'shown.bs.modal', (e) ->
    $('#calendar').addClass('grayscale') # Makes the whole table grayscale in 3 secs (making single table cells grayscale results in weird transition colors)

    # After the whole calendar is 100% grayscale, remove its class again, and set it directly on the cells (without animation)
    setTimeout (=>
      $('#calendar').removeClass('grayscale')
      $('#calendar td').addClass('grayscale')
    ), 3000