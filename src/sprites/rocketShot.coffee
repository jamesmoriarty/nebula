Q.Shot.extend 'RocketShot',

  init: (p) ->
    @_super Q._extend
        asset: 'rocketShot.png'
        damage: 7.5
        ttl: 5000
      , p

    @on "step", @, "step"
    @on "hit", (col) ->
      otherEntity = col.obj
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
          opacityRate: -.001
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

      @destroy()

  step: ->
    if Q._loopFrame % 2 == 0
      @stage.insert new Q.Particle
        x:  @p.x
        y:  @p.y
        vx: @p.vx - Q.offsetX(@p.angle, Math.max(@p.vx * 0.1, 75))
        vy: @p.vy - Q.offsetY(@p.angle, Math.max(@p.vy * 0.1, 75))

