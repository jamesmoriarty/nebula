 Q.Sprite.extend 'Player',

    init: (p) ->
      @_super p,
        asset: 'spaceship.png'
        z: 10

      @add('2d')

      Q.input.on 'up', @, 'up'
      Q.input.on 'left', @, 'left'
      Q.input.on 'right', @, 'right'
      Q.input.on 'fire', @, 'fire'

    up: ->
      @p.vx += Q.offsetX(@p.angle, 10)
      @p.vy += Q.offsetY(@p.angle, 10)

    left: ->
      @p.angle -= 10

    right: ->
      @p.angle += 10

    fire: ->
      velocity = 500
      accuracy = Math.floor((Math.random() * 5) - 5)
      angle    = @p.angle + accuracy

      @stage.insert new Q.BlasterShot
        x:  @p.x + Q.offsetX(@p.angle, @p.cx * 2)
        y:  @p.y + Q.offsetY(@p.angle, @p.cy * 2)
        vx: @p.vx + Q.offsetX(angle, velocity)
        vy: @p.vy + Q.offsetY(angle, velocity)
        angle: angle

      Q.audio.play('blasterShot.mp3');

    step: (dt) ->
      if Q.inputs['up']
        @stage.insert new Q.Particle
          x:  @p.x - Q.offsetX(@p.angle, @p.cx)
          y:  @p.y - Q.offsetY(@p.angle, @p.cy)
          vx: @p.vx - Q.offsetX(@p.angle, Math.max(@p.vx * 0.1, 5))
          vy: @p.vy - Q.offsetY(@p.angle, Math.max(@p.vy * 0.1, 5))
      else
        @p.vx *= 0.99
        @p.vy *= 0.99

