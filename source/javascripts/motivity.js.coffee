class MotivityViewModel
  constructor: ->
    @address = ko.observable('')
    @countdownRunning = false

    @limits = [
      10,
      20,
      30
    ]

    @currentLimitId = ko.observable(-1)
    @failureMsg = ko.observable(null)
    @infoMsg = ko.observable('Bitte beginnen Sie mit der Eingabe, um die den Countdown zu starten.')
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
      return if @address() == 'Postfinance'
                @countdownRunning = false
                true
              else
                false

    @inputOkay = =>
      if "Postfinance".indexOf(@address()) == 0
      else
        false

    @startCountdown = =>
      @infoMsg(null)

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
                @clearInput()
                @failureMsg("Leider zu langsam. Versuchen Sie es erneut, dieses Mal mit #{@currentLimit()} Sekunden Zeitlimit.")
              else
                @failureMsg("Sie haben es leider nicht geschafft.")
                @gameOver(true)
        ), 1000

    @clearInput = =>
      $('#address').val ''
      $('#address').prop('disabled', true)
      setTimeout (->
        $('#address').prop('disabled', false).focus()
      ), 3000

    @next = =>
      @currentLimitId(@currentLimitId() + 1)
      @currentLimit(@limits[@currentLimitId()])
      $('#current_limit').text @currentLimit()
      @countdownRunning = false

    @next()

$ ->
  $('body.motivity').each ->
    ko.applyBindings new MotivityViewModel

  $('#motivity_simulation').on "shown.bs.modal", ->
    $('#address').focus()