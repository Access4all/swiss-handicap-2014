class ParaplegiaViewModel
  constructor: ->
    @address = ko.observable('')

    @inputEmpty = =>
      @address() == ''

    @inputComplete = =>
      @address() == 'www.postfinance.ch'

    @inputOkay = =>
      "www.postfinance.ch".indexOf(@address()) == 0

$ ->
  $('body.paraplegia').each ->
    ko.applyBindings new ParaplegiaViewModel
