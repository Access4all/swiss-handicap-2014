class BlindnessViewModel
  constructor: ->
    @audioPlayer = new AudioPlayer

    @answers = [
      {value: 'Mahatma Gandhi',       correct: false},
      {value: 'Mutter Teresa',        correct: false},
      {value: 'Albert Schweizer',     correct: true},
      {value: 'Hildegard von Bingen', correct: false}
    ]

    @playAudio = ->
      @audioPlayer.play()

    @answer = (value) =>
      if value.correct
        console.log 'true! congratulations!'
      else
        if @audioPlayer.hasNext()
          @audioPlayer.next()
          console.log "leider falsch, nächster versucht #{@audioPlayer.currentAudio()}"
        else
          console.log 'verloren!'

class AudioPlayer
  constructor: ->
    @audios = [
      'audios/fast.mp3',
      'audios/medium.mp3',
      'audios/slow.mp3'
    ]

    @currentAudioId = -1

    @currentAudio = ->
      @audios[@currentAudioId]

    @play = ->
      @player.play()

    @hasNext = ->
      @currentAudioId + 1 < @audios.length

    @next = ->
      console.error 'There is not next audio!' unless @hasNext

      @currentAudioId += 1
      @player = new Audio(@currentAudio())

    @next()

$ ->
  $('body.blindness').each ->
    ko.applyBindings new BlindnessViewModel
