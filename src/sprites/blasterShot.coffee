Q.Sprite.extend 'BlasterShot',

  init: (p) ->
    @_super Q._extend
        type: Q.SPRITE_ENEMY
        collisionMask: Q.SPRITE_FRIENDLY
        asset: 'blasterShot.png'
        z: 5
        damage: 1
        ttl: 1000
      , p

    @add('2d')
    @add('ttl')

    @on 'hit', (col) ->
      unless col.obj.isA "BlasterShot"
        for [1..5]
          vd = Q.random -5, 5
          @stage.insert new Q.Particle
            x:  col.obj.p.x + vd
            y:  col.obj.p.y + vd
            vx: col.normalX * vd
            vy: col.normalY * vd
        Q.audio.play 'hit.mp3'

      @destroy()

  draw: (ctx) ->
    ctx.save()
    ctx.globalCompositeOperation = 'lighter'
    @_super(ctx)
    ctx.restore()

