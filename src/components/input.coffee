Q.component 'input',

  added: ->
    @entity.on "step", @, "step"

  step: (dt) ->
    if Q.mouseEnabled and Q.inputs['mouseX'] and Q.inputs['mouseY']
      targetAngle = Q.normalizeAngle(@entity.p.angle - Q.angle @entity.p.x, @entity.p.y, Q.inputs['mouseX'], Q.inputs['mouseY'])
      if targetAngle > 180
        @entity.trigger 'left', dt
      else
        @entity.trigger 'right', dt

      if Q.inputs['mouse']
        @entity.trigger 'fire'

    if Q.inputs['fire']
      @entity.trigger 'fire'

    if Q.inputs['up'] or Q.inputs['action']
      @entity.trigger 'up', dt

    if Q.inputs['left']
      @entity.trigger 'left', dt

    if Q.inputs['right']
      @entity.trigger 'right', dt

