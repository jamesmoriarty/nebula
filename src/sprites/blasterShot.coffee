Q.Sprite.extend 'BlasterShot',

  init: (p) ->
    @_super Q._extend
        type: Q.SPRITE_ACTIVE
        collisionMask: Q.SPRITE_ACTIVE
        asset: 'particle.png'
        z: 5
        scale: 0.4
      , p

    @add('2d')

    @on 'hit', (col) ->
      for [1..5]
        vd = Q.random -5, 5
        @stage.insert new Q.Particle
          x:  col.obj.p.x + vd
          y:  col.obj.p.y + vd
          vx: col.normalX * vd
          vy: col.normalY * vd

      @destroy()

      Q.audio.play 'hit.mp3'

