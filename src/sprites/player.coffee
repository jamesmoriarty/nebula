 Q.Sprite.extend 'Player',

    init: (p) ->
      @_super p,
        asset: 'spaceship.png'
        gravity: 0

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
      #@stage.insert new Q.Particle
      #  x:  @p.x - Q.offsetX(@p.angle, 32) * 32
      #  y:  @p.y - Q.offsetY(@p.angle, 32) * 32
      #  vx: @p.vx
      #  vy: @p.vy
      @_super dt

