Q.Sprite.extend 'Ship',

  init: (p) ->
    @_super Q._extend
        type: Q.SPRITE_DEFAULT
        collisionMask: Q.SPRITE_ACTIVE
      , p

    @add('2d')

  fire: ->
    @weapon.tryFire(@)

  accelerate: (dt) ->
    vx = @p.vx
    vy = @p.vy

    @p.vx += Q.offsetX(@p.angle, Q[@className].acceleration) * dt
    @p.vy += Q.offsetY(@p.angle, Q[@className].acceleration) * dt

    if Q.distance(@p.vx, @p.vy) > 500
      @p.vx = vx
      @p.vy = vy

    @stage.insert new Q.Particle
      x:  @p.x -  Q.offsetX(@p.angle, @p.cx)
      y:  @p.y -  Q.offsetY(@p.angle, @p.cy)
      vx: @p.vx - Q.offsetX(@p.angle, Math.max(@p.vx * 0.1, 75))
      vy: @p.vy - Q.offsetY(@p.angle, Math.max(@p.vy * 0.1, 75))

  turn: (dt, degree) ->
    @p.angle += degree * dt

  friction: (dt) ->
      @p.vx *= (1 - dt)
      @p.vy *= (1 - dt)

