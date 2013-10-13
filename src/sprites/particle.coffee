Q.Sprite.extend 'Particle',
  init: (p) ->
    @._super p,
      asset: 'particle.png'
      type: Q.SPRITE_NONE
    @.add('2d')

  update: (dt) ->
    #@scale *= 0.999999999
    @._super dt

  draw: (ctx) ->
    ctx.globalCompositeOperation = 'lighter'
    if @p.sheet
      @sheet().draw ctx, -@p.cx, -@p.cy, @p.frame
    else if(@p.asset)
      ctx.drawImage Q.asset(@p.asset), -@p.cx, -@p.cy
