Q.Shot.extend 'BlasterShot',

  init: (p) ->
    @_super Q._extend
        asset: 'blasterShot.png'
        damage: 1
      , p

    @on "sensor", (otherEntity) ->
      n = Q.random 1, 3
      for [1..n]
        @stage.insert new Q.Particle
          x:  otherEntity.p.x
          y:  otherEntity.p.y
          vx: Q.random -50, 50
          vy: Q.random -50, 50

      Q.audio.play 'hit.mp3'
      @destroy()

  draw: (ctx) ->
    ctx.save()
    ctx.globalCompositeOperation = 'lighter'
    @_super(ctx)
    ctx.restore()

