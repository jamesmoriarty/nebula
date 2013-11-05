Q.component 'aiHunter',

  added: ->
    @entity.on "step", @, "step"

  step: (dt) ->
    if !@target
      loop
        @target = Q._shuffle(Q("SmallShip").items)[0]
        break if @target.p.asset != @entity.p.asset
    else
      targetAngle = @entity.p.angle - Q.angle @entity.p.x, @entity.p.y, @target.p.x, @target.p.y
      if targetAngle > 0
        @entity.turn dt, -Q[@entity.className].rotation
      else
        @entity.turn dt,  Q[@entity.className].rotation

      targetDistance = Q.distance(@entity.p.x, @entity.p.y, @target.p.x, @target.p.y)
      if Math.abs(targetAngle) < 10 and targetDistance < 200
        @entity.fire()
      else
        @entity.accelerate dt

