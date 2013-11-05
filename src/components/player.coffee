Q.component 'player',

  added: ->
    @entity.on "step", @, "step"

  step: (dt) ->
    if Q.inputs['up'] or Q.inputs['action']
      @entity.accelerate dt
    else
      @entity.friction dt

    if Q.inputs['fire']
      @entity.fire()

    if Q.inputs['left']
      @entity.turn dt, -Q[@entity.className].rotation

    if Q.inputs['right']
      @entity.turn dt,  Q[@entity.className].rotation

