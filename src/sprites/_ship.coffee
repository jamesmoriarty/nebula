Q.Sprite.extend 'Ship',

  init: (p) ->
    @_super Q._extend
        sensor: true
        type: Q.SPRITE_FRIENDLY
        z: 10
        hp: 10
        maxHp: 10
        recharge: .1
      , p

    @add '2d'
    @add 'damageable'

    @on 'up', @, 'up'
    @on 'left', @, 'left'
    @on 'right', @, 'right'
    @on 'destroyed', @, 'destroyed'

  step: (dt) ->
    if @p.recharge * dt + @p.hp < @p.maxHp
      @p.hp = @p.hp + @p.recharge * dt

  up: (dt) ->
    @p.vx += Q.offsetX(@p.angle, Q[@className].acceleration) * dt
    @p.vy += Q.offsetY(@p.angle, Q[@className].acceleration) * dt

    if Q.distance(@p.vx, @p.vy) > Q[@className].maxVelocity
      distance = Q.distance @p.vx, @p.vy
      @p.vx = @p.vx / distance * Q[this.className].maxVelocity
      @p.vy = @p.vy / distance * Q[this.className].maxVelocity

    if Q._loopFrame % 2 == 0
      @stage.insert new Q.Particle
        x:  @p.x -  Q.offsetX(@p.angle, @p.cx)
        y:  @p.y -  Q.offsetY(@p.angle, @p.cy)
        vx: @p.vx - Q.offsetX(@p.angle, Math.max(@p.vx * 0.1, 75))
        vy: @p.vy - Q.offsetY(@p.angle, Math.max(@p.vy * 0.1, 75))

  turn: (dt, degree) ->
    @p.angle += degree * dt

  right: (dt) ->
    @turn dt,  Q[@className].rotation

  left: (dt) ->
    @turn dt, -Q[@className].rotation

  destroyed: (dt) ->
    Q.audio.play 'exp.mp3'

    for n in [1..10]
      angle = @p.angle + Math.random() * 270
      @stage.insert new Q.Particle
        x:  @p.x
        y:  @p.y
        vx: @p.vx - Q.offsetX(angle, angle)
        vy: @p.vy - Q.offsetY(angle, angle)
        scale: Math.max(Math.random(), 0.3)

