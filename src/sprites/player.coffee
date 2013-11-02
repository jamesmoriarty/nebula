Q.Ship.extend 'Player',

  init: (p) ->
    @_super Q._extend
        type: Q.SPRITE_DEFAULT
        asset: 'ship.png'
      , p

    @weapon = new Q.Blaster

  step: (dt) ->
    if Q.inputs['up'] or Q.inputs['action']
      @accelerate(dt)
    else
      @friction(dt)

    if Q.inputs['fire']
      @fire()

    if Q.inputs['left']
      @turn(dt, -100)

    if Q.inputs['right']
      @turn(dt,  100)

, acceleration: 100

