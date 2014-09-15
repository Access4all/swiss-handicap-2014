//= require jquery
//= require bootstrap
//= require jquery.textchange

//= require blindness
//= require colorblindness
//= require motivity
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
        window.location = "/"
      awayTimeout: 180000 # 5mins
    )
