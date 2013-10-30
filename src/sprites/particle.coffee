Q.Sprite.extend 'Particle',

  init: (p) ->
    @_super p,
      asset: 'particle.png'
      type: Q.SPRITE_NONE
      z: 5
      opacity: 0.5
      scale: 0.5

    @add('2d')

    @.on 'step', (dt) ->
      @p.vx *= (1 - dt)
      @p.vy *= (1 - dt)
      if @p.scale >= 0
        @p.scale -= dt / 2
      else
        @.destroy()

  draw: (ctx) ->
    ctx.globalCompositeOperation = 'lighter'

    @_super(ctx)

