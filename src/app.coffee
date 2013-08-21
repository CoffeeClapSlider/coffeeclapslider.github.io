(( $ )->
  $.fn.CoffeeClapSlider = ( opt )->
##  Default settings
    s = $.extend
      'cssReset' : { "padding": "0", "margin": "0", "max-width": "none" },
      'width'    : '500',
      'height'   : '300',
      'autoPlay' : true,
      'time'     : 3000,
      'speed'    : 600
      'btnNext'  : undefined
      'btnPrev'  : undefined
    , opt

## width  <ul> object, and count of <li> objects
    ulWidth = 0
    liCount = 0
    animate = false
    @find( 'img' ).each ->
      ulWidth += $( @ ).width()
      liCount++

## CSS Style
    Style   =
      "div" :
        "width"     : s.width + "px"
        "overflow"  : "hidden"
        "height"    : s.height + "px"
      "ul" :
        "height"    : s.height + "px"
        "list-style": "none"
        "width"     : ulWidth
      "li" :
        "float"     : "left"

## Constructor
    @init = =>
      @find( '*' ).css(  s.cssReset )

      @css( Style.div )
      .find( 'ul' ).css( Style.ul )
      .find( 'li' ).css( Style.li )
      .find( 'li' ).css( 'height', "#{s.height}px", "important" )

      if s.autoPlay then setInterval =>
        if s.autoPlay
          @move( "next" )
      , s.time

## if btnNext  exist, bind event "click" on this
    if s.btnNext then s.btnNext.click ( even )=>
      even.preventDefault()
      s.autoPlay = false
      @move( "next" )

## if btnPrev  exist, bind event "click" on this
    if s.btnPrev then s.btnPrev.click ( even )=>
      even.preventDefault()
      s.autoPlay = false
      @move( "prev" )


    move =
      "next": =>
        li = @find( 'li' ).eq( 0 )
        li.clone().appendTo $( @ ).find( "ul" )
        li.animate { "width": 0 }, s.speed, ->
          $( @ ).remove()
          animate = false
      "prev": =>
        li = @find( 'li' ).eq( liCount - 1 )
        li.css(
          "width": 0
        ).clone().prependTo $( @ ).find( "ul" )
        @find( 'li' ).eq( 0 ).animate {"width": s.width}, s.speed, ->
          li.remove()
          animate = false

    @move = ( to = 'next' )=>
      if !animate and to in ['next', 'prev']
        animate = true
        move[ to ]()

    @init()
    return @

)(jQuery)