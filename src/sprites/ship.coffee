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
        vx: @p.vx - Q.offsetX(@p.angle, Math.max(@p.vx * 0.2, 100))
        vy: @p.vy - Q.offsetY(@p.angle, Math.max(@p.vy * 0.2, 100))

  turn: (dt, degree) ->
    @p.angle += degree * dt

  right: (dt) ->
    @turn dt,  Q[@className].rotation

  left: (dt) ->
    @turn dt, -Q[@className].rotation

  destroyed: (dt) ->
    Q.audio.play 'exp.mp3'

    for n in [1..30]
      angle = @p.angle + Math.random() * 270
      @stage.insert new Q.Particle
        color: '#111'
        x:  @p.x
        y:  @p.y
        vx: @p.vx - Q.offsetX(angle, Math.random() * 50)
        vy: @p.vy - Q.offsetY(angle, Math.random() * 50)
        scale: 1
        sclaeRate: .02
        opacityRate: -.01
        radius: 16

    for n in [1..10]
      angle = @p.angle + Math.random() * 270
      @stage.insert new Q.Particle
        color: 'orange'
        x:  @p.x
        y:  @p.y
        vx: @p.vx - Q.offsetX(angle, 10)
        vy: @p.vy - Q.offsetY(angle, 10)
        scale: Math.max(Math.random(), 0.3)
        scale: 1
        sclaeRate: .02
        radius: 16

    for n in [1..10]
      angle = @p.angle + Math.random() * 270
      @stage.insert new Q.Particle
        color: 'white'
        x:  @p.x
        y:  @p.y
        vx: @p.vx - Q.offsetX(angle, 200)
        vy: @p.vy - Q.offsetY(angle, 200)
        scale: Math.max(Math.random(), 0.3)
        scaleRate: -.01
        opacityRate: -.01

