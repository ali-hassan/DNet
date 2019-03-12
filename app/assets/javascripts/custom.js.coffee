$(document).on "turbolinks:load", ->
  $(document).on "submit", "[data-pin-verify]", (eventObject) ->
    eventObject.preventDefault()
    $.getScript($(@).data('pin-verify'))
    window.$FormToSubmit= $(eventObject.currentTarget)
  $flashMessage = $('.flash-message')
  if $flashMessage.length
    setTimeout ( ->
      $('.flash-message').remove()
    ), 6000
  $(document).on 'click', '.flash-message .close-btn', (eventObject) ->
    $(this).parents('.flash-message').remove()
  $(document).on "click", ".copy-link-label", (eventObject) ->
    eventObject.preventDefault()
    val = $(this).find('input')[0]
    val.select()
    document.execCommand('copy')
    alert("link coppied")

  $(document).on "keyup", "#sponsor_id_txt", (eventObject) ->
    if @value.length > 1
      $.getScript("/verify_sponsor_users/#{ @value }.js")


  $referTriggerSearch  = $(".trigger-refer-search")
  if $referTriggerSearch.length
    $referTriggerSearch.trigger('keyup')
