class BlindnessViewModel
  constructor: ->
    @playAudio = ->
      @play()

    @currentAttempt = ->
      @currentAudioId() + 1

    @totalAttempts = ->
      @audios.length

    @answer = =>
      if @hasNext()
        alert "Versuchen Sie es noch einmal; die Geschwindigkeit wird gedrosselt."
        @next()
      else
        alert "Leider verloren!"

    @chooseAnswer = ko.observable(false)

    @audios = [
      'schnell',
      'mittel',
      'langsam'
    ]

    @currentAudioId = ko.observable(-1)

    @currentAudio = ->
      @audios[@currentAudioId()]

    @play = ->
      @player.play()

    @hasNext = ->

    @hasNext = ko.computed(->
      @currentAudioId() + 1 < @audios.length
    , this)

    @next = ->
      @currentAudioId(@currentAudioId() + 1)
      @player = new Audio("audios/#{@currentAudio()}.mp3")

      @chooseAnswer(false)
      @player.addEventListener 'ended', (=>
        @chooseAnswer(true)
      ), false

    @next()

$ ->
  $('body.blindness').each ->
    ko.applyBindings new BlindnessViewModel
