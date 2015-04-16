# Valid positions include:
# - panel-left
# - panel-right (initial position)
# - panel-bottom
#
# Also the panel is either open or closed (the default).

transitionDelay = 300

wait = (msDelay) ->
  new RSVP.Promise (resolve) ->
    setTimeout (-> resolve()), msDelay

class Panel
  constructor: (initialPosition) ->
    @opened = false
    @setInitialPosition initialPosition

  open: ->
    console.log 'received open'
    new RSVP.Promise (resolve) =>
      if !@opened
        console.log 'opening'
        $('#wrapper').addClass('opened')
        @opened = true
        wait(transitionDelay).then ->
          resolve()
      else
        resolve()

  close: ->
    console.log 'received close'
    new RSVP.Promise (resolve) =>
      if @opened
        console.log 'closing'
        $('#wrapper').removeClass('opened')
        @opened = false
        wait(transitionDelay).then -> resolve()
      else
        resolve()

  clearPosition: ->
    new RSVP.Promise (resolve) =>
      $('#wrapper').removeClass(@position)
      wait(transitionDelay).then -> resolve()

  updatePosition: ->
    new RSVP.Promise (resolve) =>
      $('#wrapper').addClass(@position)
      wait(transitionDelay).then -> resolve()

  setInitialPosition: (initialPosition) ->
    @position = initialPosition
    $('#wrapper').addClass(@position)
    @setPositionLabel()

  setPositionLabel: ->
    $('#panel-position-label').html @position

  setPosition: (newPosition) ->
    @close().then(=>
      @clearPosition()
    ).then(=>
      @position = newPosition
      @updatePosition()
    ).then(=>
      @open()
    ).then =>
      @setPositionLabel()
    null

panel = new Panel('panel-right')

$("#menu-close").click (e) ->
  panel.close().then ->
    cosole.log 'closed'
  $("#menu-close").blur()

$("#menu-open").click (e) ->
  panel.open().then ->
    cosole.log 'opened'
  $("#menu-open").blur()

$("#menu-put-left").click (e) ->
  panel.setPosition 'panel-left'
  $("#menu-put-left").blur()

$("#menu-put-bottom").click (e) ->
  panel.setPosition 'panel-bottom'
  $("#menu-put-bottom").blur()

$("#menu-put-right").click (e) ->
  panel.setPosition 'panel-right'
  $("#menu-put-right").blur()

# END
