class MotivityViewModel
  constructor: ->
    @address = ko.observable('')
    @countTime = false

    @inputEmpty = =>
      @address() == ''

    @inputComplete = =>
      return if @address() == 'www.postfinance.ch'
                @countTime = false
                true
              else
                false

    @inputOkay = =>
      "www.postfinance.ch".indexOf(@address()) == 0

    @startTimer = =>
      @countTime = true

    @pad = (val) ->
      (if val > 9 then val else "0" + val)

    sec = 0
    setInterval (=>
      if @countTime
        $("#timer .seconds").html @pad(++sec % 60)
        $("#timer .minutes").html @pad(parseInt(sec / 60, 10))
    ), 1000

$ ->
  $('body.motivity').each ->
    ko.applyBindings new MotivityViewModel
