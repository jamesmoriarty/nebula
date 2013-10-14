 Q.Sprite.extend 'Player',

    init: (p) ->
      @_super p,
        asset: 'spaceship.png'
        gravity: 0
        z: 10

      @add('2d')

      Q.input.on 'up', @, 'up'
      Q.input.on 'left', @, 'left'
      Q.input.on 'right', @, 'right'

    up: ->
      @p.vx += Q.offsetX(@p.angle, 10)
      @p.vy += Q.offsetY(@p.angle, 10)

    left: ->
      @p.angle -= 10

    right: ->
      @p.angle += 10

    update: (dt) ->
      if Q.inputs['up']
        @stage.insert new Q.Particle
          x:  @p.x - Q.offsetX(@p.angle, @p.cx)
          y:  @p.y - Q.offsetY(@p.angle, @p.cy)
      else
        @p.vx *= 0.99
        @p.vy *= 0.99

      @_super(dt)

