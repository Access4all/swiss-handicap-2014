//= require jquery
//= require bootstrap

//= require blindness
//= require colorblindness
//= require paraplegia
//= require seniority

$ ->
  # Hide opened modals when opening another modal
  $(".modal").on "show.bs.modal", ->
    current_modal = @
    $(".modal").each ->
      $(this).modal "hide" unless @ is current_modal

  # Restart app after some time
  unless window.location.pathname is "/"
    new Idle(
      onAway: =>
        location.reload(true)
      awayTimeout: 300000 # 5mins
    )
