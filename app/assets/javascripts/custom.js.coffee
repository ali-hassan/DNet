$(document).on "turbolinks:load", ->
  $("body").on "click",  ".promotion-href", (e) ->
    e.preventDefault()
    $("#alert_welcome_popup").modal()
  if getParameterByName('open_welcome_modal')
    $("#alert_welcome_popup").modal()
  readFileURL = (input) ->
    if input.files && input.files[0]
      reader = new FileReader()
      reader.onload = (e) ->
        $("#uploaded_document").html("<img src='#{e.target.result}' width='200' height='200' />")
      reader.readAsDataURL(input.files[0])
  $('.document-upload-field').on 'change', (eventObject) ->
    readFileURL(this)
  $(".coming-soon-payment-prompt").off("click")
  $(document).on "click", ".coming-soon-payment-prompt", (eventObject) ->
    eventObject.preventDefault()
    alert("Coming Soon")
    $(".coming-soon-payment-prompt").off("click")
  $(document).on "submit", "[data-pin-verify]", (eventObject) ->
    eventObject.preventDefault()
    $.getScript($(@).data('pin-verify'))
    window.$FormToSubmit= $(eventObject.currentTarget)
  $flashMessage = $('.flash-message')
  #if $flashMessage.length
  if false
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
    $(".copy-link-label").off("click")

  $(document).on "change", "#sponsor_id_txt", (eventObject) ->
    userName = currentUserName
    if @value.length > 1
      if currentUserName == @value
        alert("You can not perform this action")
      else
        $.getScript("/verify_sponsor_users/#{ @value }.js")


  $referTriggerSearch  = $(".trigger-refer-search")
  if $referTriggerSearch.length
    $referTriggerSearch.trigger('keyup')

  $(document).on "click", "#live_trading", (eventObject) ->
    eventObject.preventDefault();
    alert("DNet live trading will be available very soon");
    $("#live_trading").off("click");
  $(document).on "click", "#promotion_trading", (eventObject) ->
    eventObject.preventDefault();
    #alert("Something big is coming, Stay tuned.");
    $("#live_trading").off("click");
