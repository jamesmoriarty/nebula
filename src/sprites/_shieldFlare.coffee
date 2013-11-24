Q.Sprite.extend 'ShieldFlare',

  init: (p) ->
    @_super Q._extend
        asset: 'shieldFlare.png'
        type: Q.SPRITE_NONE
        collisionMask: Q.SPRITE_NONE
        opacity: .5
        opacityRate: -.03
        z: 5
        ttl: 200
      , p

    @add('2d')
    @add('ttl')

  step: (dt) ->
    @p.vx *= (1 - dt)
    @p.vy *= (1 - dt)

    if @p.opacity >= 0
      @p.opacity += @p.opacityRate
    else
      @destroy()
