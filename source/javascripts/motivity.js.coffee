class MotivityViewModel
  constructor: ->
    @address = ko.observable('')
    @countTime = false

    @limits = [
      2,
      4,
      6
    ]

    @currentLimitId = ko.observable(-1)

    @currentLimit = ko.observable(0)

    @hasNext = ko.computed(->
      @currentLimitId() + 1 < @limits.length
    , this)

    @currentAttempt = ->
      @currentLimitId() + 1

    @totalAttempts = ->
      @limits.length

    @inputEmpty = =>
      @address() == ''

    @inputComplete = =>
      return if @address() == 'postfinance'
                @countTime = false
                true
              else
                false

    @inputOkay = =>
      "postfinance".indexOf(@address()) == 0

    @startCountdown = =>
      @countTime = true

      timer = setInterval (=>
        if @countTime
          @currentLimit(@currentLimit() - 1)

          if @currentLimit() == 0
            clearInterval timer
            alert 'zu langsam!'

            if @hasNext()
              @next()
            else
              alert 'verloren!'
      ), 1000

    @next = ->
      @currentLimitId(@currentLimitId() + 1)
      @currentLimit(@limits[@currentLimitId()])
      $('#current_limit').replaceWith @currentLimit()

    @next()

$ ->
  $('body.motivity').each ->
    ko.applyBindings new MotivityViewModel
