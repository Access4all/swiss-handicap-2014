//= require jquery
//= require bootstrap

//= require blindness
//= require colorblindness

$ ->
  $(".modal").on "show.bs.modal", ->
    current_modal = @
    $(".modal").each ->
      $(this).modal "hide" unless @ is current_modal
