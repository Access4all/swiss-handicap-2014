class BlindnessViewModel
  constructor: ->
    @answers = [
      {value: 'Mahatma Gandhi',       correct: false},
      {value: 'Mutter Teresa',        correct: false},
      {value: 'Albert Schweizer',     correct: true},
      {value: 'Hildegard von Bingen', correct: false}
    ]

    @playAudio = ->
      @play()

    @currentAttempt = ->
      @currentAudioId() + 1

    @totalAttempts = ->
      @audios.length

    @answer = (value) =>
      if value.correct
        alert "Gewonnen!"
      else
        if @hasNext()
          alert "Leider falsch. Versuchen Sie es noch einmal; die Geschwindigkeit wird gedrosselt."
          @next()
        else
          alert "Leider verloren!"

    @chooseAnswer = ko.observable(false)

    @audios = [
      'audios/fast.mp3',
      'audios/medium.mp3',
      'audios/slow.mp3'
    ]

    @currentAudioId = ko.observable(-1)

    @currentAudio = ->
      @audios[@currentAudioId()]

    @play = ->
      @player.play()

    @hasNext = ->
      @currentAudioId() + 1 < @audios.length

    @next = ->
      console.error 'There is no next audio!' unless @hasNext

      @currentAudioId(@currentAudioId() + 1)
      @player = new Audio(@currentAudio())

      @chooseAnswer(false)
      @player.addEventListener 'ended', (=>
        @chooseAnswer(true)
      ), false

    @next()

$ ->
  $('body.blindness').each ->
    ko.applyBindings new BlindnessViewModel
