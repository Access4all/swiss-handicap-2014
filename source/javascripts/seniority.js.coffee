class SeniorityViewModel
  constructor: ->
    @resolution = ko.observable('')

    @inputEmpty = =>
      @resolution() == ''

    @inputComplete = =>
      @resolution() == 'Barrierefreiheit'

    @inputOkay = =>
      "Barrierefreiheit".search(@resolution()) == 0

$ ->
  $('body.seniority').each ->
    ko.applyBindings new SeniorityViewModel
