Q.Ship.extend 'Player',

  init: (p) ->
    @_super p

    Q.input.on 'fire', @, 'fire'

  step: (dt) ->
    if Q.inputs['up'] or Q.inputs['action']
      @accelerate(dt)
    else
      @friction(dt)
    if Q.inputs['left']
      @turn(dt, -100)
    if Q.inputs['right']
      @turn(dt,  100)

