Q.Sprite.extend 'Particle',

  init: (p) ->
    @_super Q._extend
        asset: 'particle.png'
        type: Q.SPRITE_NONE
        collisionMask: Q.SPRITE_NONE
        z: 5
        opacity: .5
        opacityRate: -.02
        scale: .5
        scaleRate: -.02
        color: "white"
        radius: 8
      , p

    @add('2d')

  step: (dt) ->
    @p.vx *= (1 - dt)
    @p.vy *= (1 - dt)

    if @p.opacity >= 0
      @p.opacity += @p.opacityRate
    else
      @destroy()

    if @p.scale >= 0
      @p.scale += @p.scaleRate
    else
      @destroy()

  draw: (ctx) ->
    ctx.save()
    ctx.globalCompositeOperation = 'lighter'
    ctx.fillStyle = @p.color
    ctx.beginPath()
    ctx.arc 0, 0, @p.radius, 0, 2 * Math.PI
    ctx.fill()
    ctx.restore()

