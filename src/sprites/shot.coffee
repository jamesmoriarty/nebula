Q.Sprite.extend 'Shot',

  init: (p) ->
    @_super Q._extend
        sensor: true
        type: Q.SPRITE_ENEMY
        collisionMask: Q.SPRITE_FRIENDLY
        z: 5
        ttl: 1000
      , p

    @add('2d')
    @add('ttl')

