Q.Sprite.extend 'Particle',

  init: (p) ->
    @_super Q._extend
        asset: 'particle.png'
        type: Q.SPRITE_NONE
        collisionMask: Q.SPRITE_NONE
        z: 5
        opacity: 0.5
        scale: 0.4
      , p

    @add('2d')

  step: (dt) ->
    @p.vx *= (1 - dt)
    @p.vy *= (1 - dt)
    if @p.scale >= 0
      @p.scale -= dt
    else
      @.destroy()

  draw: (ctx) ->
    ctx.save()
    ctx.globalCompositeOperation = 'lighter'
    @_super(ctx)
    ctx.restore()

