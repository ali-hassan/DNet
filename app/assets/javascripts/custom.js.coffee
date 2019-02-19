$(document).on "turbolinks:load", ->
  $(document).on "keyup", "#sponsor_id_txt", (eventObject) ->
    if @value.length > 1
      $.getScript("/verify_sponsor_users/#{ @value }.js")


