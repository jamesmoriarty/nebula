Q.Sprite.extend 'Player',
  init: (p) ->
    @_super p,
      asset: 'spaceship.png'
      z: 10

    @weapon = new Q.Blaster

    @add('2d')

    @.on 'step', 'trail'
    @.on 'step', 'friction'

    Q.input.on 'fire', @, 'fire'
    Q.input.on 'up', @, 'up'
    Q.input.on 'left', @, 'left'
    Q.input.on 'right', @, 'right'

  fire: ->
    @weapon.tryFire(@)

  up: ->
    @p.vx += Q.offsetX(@p.angle, 10)
    @p.vy += Q.offsetY(@p.angle, 10)

  left: ->
    @p.angle -= 10

  right: ->
    @p.angle += 10

  trail: (dt) ->
    if Q.inputs['up']
      @stage.insert new Q.Particle
        x:  @p.x - Q.offsetX(@p.angle, @p.cx)
        y:  @p.y - Q.offsetY(@p.angle, @p.cy)
        vx: @p.vx - Q.offsetX(@p.angle, Math.max(@p.vx * 0.1, 5))
        vy: @p.vy - Q.offsetY(@p.angle, Math.max(@p.vy * 0.1, 5))

  friction: (dt) ->
    unless Q.inputs['up']
      @p.vx *= (1 - dt)
      @p.vy *= (1 - dt)

