###!
  Tes Ok
###
$.domReady () ->

  currentPage = null
  $('.open').click (e) ->
    $this = $ this
    page = $this.attr 'href'
    if currentPage
      $(currentPage).removeClass 'active';
      $('a[href=' + currentPage + ']').removeClass 'active';

    if (currentPage != page)
      $(page)
        .addClass 'active'
        .find '.content'
        .focus()
      # $this.addClass 'active'
      $('a[href=' + page + ']').addClass 'active';
      currentPage = page;
    else
      currentPage = null;

    e.preventDefault()
    false

  $('.close').click (e) ->
    if currentPage
      $(currentPage).removeClass 'active';
      $('a[href=' + currentPage + ']').removeClass 'active';
    e.preventDefault()
    false

  clrIdx = 0
  colors = ['red', 'orange', 'green', 'blue', 'purple']

  changeColor = (newIdx) ->
    $('body')
      .removeClass colors[clrIdx]
      .addClass colors[clrIdx=newIdx]

  setInterval () ->
    changeColor (clrIdx + 1) % colors.length
  , 7000

  changeColor Math.round(Math.random() * colors.length)

  $('html').removeClass 'loading'