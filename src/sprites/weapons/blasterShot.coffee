Q.Sprite.extend 'BlasterShot',
  init: (p) ->
    @_super p,
      asset: 'particle.png'
      z: 5
      scale: 0.4

    @add('2d')

