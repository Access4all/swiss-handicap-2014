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
    @failureMsg = ko.observable(null)
    @infoMsg = ko.observable(null)
    @gameOver = ko.observable(false)

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
      if @address().length == 1 and !@countdownRunning
        @countdownRunning = true
        @failureMsg(null)

        timer = setInterval (=>
          if @countdownRunning
            @currentLimit(@currentLimit() - 1)

            if @currentLimit() == 0
              clearInterval timer

              if @hasNext()
                @next()
                @failureMsg("Leider zu langsam. Nächster Versuch mit #{@currentLimit()} Sekunden.")
              else
                @failureMsg("Sie haben es leider nicht geschafft.")
                @gameOver(true)

              $('#address').prop('disabled', true)
              player = new Audio("audios/beep.mp3")
              player.addEventListener 'ended', (=>
                $('#address').prop('disabled', false).focus()
              ), false
              player.play()
        ), 1000

    @next = =>
      $('#address').val ''
      @currentLimitId(@currentLimitId() + 1)
      @currentLimit(@limits[@currentLimitId()])
      $('#current_limit').text @currentLimit()
      @countdownRunning = false

    @next()

$ ->
  $('body.motivity').each ->
    ko.applyBindings new MotivityViewModel
