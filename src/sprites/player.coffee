Q.Sprite.extend 'Player',
  init: (p) ->
    @_super p,
      asset: 'spaceship.png'
      z: 10

    @weapon = new Q.Blaster

    @add('2d')

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

  fire: ->
    @weapon.tryFire(@)

  accelerate: (dt) ->
    @p.vx += Q.offsetX(@p.angle, 100) * dt
    @p.vy += Q.offsetY(@p.angle, 100) * dt

    @stage.insert new Q.Particle
      x:  @p.x - Q.offsetX(@p.angle, @p.cx)
      y:  @p.y - Q.offsetY(@p.angle, @p.cy)
      vx: @p.vx - Q.offsetX(@p.angle, Math.max(@p.vx * 0.1, 5))
      vy: @p.vy - Q.offsetY(@p.angle, Math.max(@p.vy * 0.1, 5))

  turn: (dt, degree) ->
    @p.angle += degree * dt

  friction: (dt) ->
      @p.vx *= (1 - dt)
      @p.vy *= (1 - dt)

