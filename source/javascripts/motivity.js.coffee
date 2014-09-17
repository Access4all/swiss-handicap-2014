class MotivityViewModel
  constructor: ->
    @address = ko.observable('')
    @countdownRunning = false

    @limits = [
      2,
      4,
      6
    ]

    @currentLimitId = ko.observable(-1)
    @failureMessage = ko.observable(null)

    @currentLimit = ko.observable(0)

    @hasNext = ko.computed(=>
      @currentLimitId() + 1 < @limits.length
    , this)

    @currentAttempt = =>
      @currentLimitId() + 1

    @totalAttempts = =>
      @limits.length

    @inputEmpty = =>
      @address() == ''

    @inputComplete = =>
      return if @address() == 'postfinance'
                @countdownRunning = false
                true
              else
                false

    @inputOkay = =>
      "postfinance".indexOf(@address()) == 0

    @startCountdown = =>
      console.log 'startCountdown'
      if @address().length == 1 and !@countdownRunning
        @countdownRunning = true
        @failureMessage(null)

        timer = setInterval (=>
          if @countdownRunning
            @currentLimit(@currentLimit() - 1)

            if @currentLimit() == 0
              clearInterval timer

              if @hasNext()
                $('#address').val ''
                @next()
                @failureMessage("Leider zu langsam. Nächster Versuch mit #{@currentLimit()} Sekunden.")
              else
                console.log 'Verloren'
        ), 1000

    @next = =>
      @currentLimitId(@currentLimitId() + 1)
      @currentLimit(@limits[@currentLimitId()])
      $('#current_limit').text @currentLimit()
      @countdownRunning = false

    @next()

$ ->
  $('body.motivity').each ->
    ko.applyBindings new MotivityViewModel
