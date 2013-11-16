Q.Sprite.extend 'BlasterShot',

  init: (p) ->
    @_super Q._extend
        sensor: true
        type: Q.SPRITE_ENEMY
        collisionMask: Q.SPRITE_FRIENDLY
        asset: 'blasterShot.png'
        z: 5
        damage: 1
        ttl: 1000
      , p

    @add('2d')
    @add('ttl')

    @on "sensor", (otherEntity) ->
      for [1..5]
        vd = Q.random -5, 5
        @stage.insert new Q.Particle
          x:  otherEntity.p.x + vd
          y:  otherEntity.p.y + vd
          vx: vd
          vy: vd

      Q.audio.play 'hit.mp3'
      @destroy()

  draw: (ctx) ->
    ctx.save()
    ctx.globalCompositeOperation = 'lighter'
    @_super(ctx)
    ctx.restore()

