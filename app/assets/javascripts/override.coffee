$ ->
  $("#ceo").on "click", ->
    $('html,body').animate { scrollTop: $('#ceo_text').offset().top }, 'slow'
    event.preventDefault();

  $("#vision").on "click", ->
    $('html,body').animate { scrollTop: $('#vision_text').offset().top }, 'slow'
    event.preventDefault();

  $("#why_us").on "click", ->
    $('html,body').animate { scrollTop: $('#why_forex_text').offset().top }, 'slow'
    event.preventDefault();

  $("#forex").on "click", ->
    $('html,body').animate { scrollTop: $('#forex_text').offset().top }, 'slow'
    event.preventDefault();

  $("#plans").on "click", ->
    $('html,body').animate { scrollTop: $('#plan_text').offset().top }, 'slow'
    event.preventDefault();

  $("#packages").on "click", ->
    $('html,body').animate { scrollTop: $('#plan_text').offset().top }, 'slow'
    event.preventDefault();

  $("#contact").on "click", ->
    $('html,body').animate { scrollTop: $('#contact_text').offset().top }, 'slow'
    event.preventDefault();
