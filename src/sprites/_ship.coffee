Q.Sprite.extend 'Ship',

  init: (p) ->
    @_super Q._extend
        type: Q.SPRITE_FRIENDLY
        z: 10
        hp: 10
        maxHp: 10
      , p

    @add('2d')

    @add('damageable')

  fire: ->
    if @weapon
      @weapon.tryFire(@)

  accelerate: (dt) ->
    vx = @p.vx
    vy = @p.vy

    @p.vx += Q.offsetX(@p.angle, Q[@className].acceleration) * dt
    @p.vy += Q.offsetY(@p.angle, Q[@className].acceleration) * dt

    if Q.distance(@p.vx, @p.vy) > Q[@className].maxVelocity
      @p.vx = vx
      @p.vy = vy

    if Q._loopFrame % 2 == 0
      @stage.insert new Q.Particle
        x:  @p.x -  Q.offsetX(@p.angle, @p.cx)
        y:  @p.y -  Q.offsetY(@p.angle, @p.cy)
        vx: @p.vx - Q.offsetX(@p.angle, Math.max(@p.vx * 0.1, 75))
        vy: @p.vy - Q.offsetY(@p.angle, Math.max(@p.vy * 0.1, 75))

  turn: (dt, degree) ->
    @p.angle += degree * dt

