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
      @destroy()
