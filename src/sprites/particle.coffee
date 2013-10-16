Q.Sprite.extend 'Particle',
  init: (p) ->
    @_super p,
      asset: 'particle.png'
      type: Q.SPRITE_NONE
      z: 5
      opacity: 0.5
      scale: 0.5

    @add('2d')

    @.on 'step', ->
      @p.vx *= 0.99
      @p.vy *= 0.99
      if @p.scale >= 0
        @p.scale -= 0.01
      else
        @.destroy()

  draw: (ctx) ->
    ctx.globalCompositeOperation = 'lighter'

    @_super(ctx)

