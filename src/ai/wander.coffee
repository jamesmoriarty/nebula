Q.component 'aiWander',

  added: ->
    @entity.on "step", @, "step"

  step: (dt) ->
    if !@targetX or !@targetY or 50 > Q.distance(@entity.p.x, @entity.p.y, @targetX, @targetY)
      @targetX = Math.random() * 1000
      @targetY = Math.random() * 1000

    targetAngle = Q.angle @entity.p.x, @entity.p.y, @targetX, @targetY
    if @entity.p.angle - targetAngle > 0
      @entity.turn dt, -100
    else
      @entity.turn dt, 100

    @entity.accelerate dt

