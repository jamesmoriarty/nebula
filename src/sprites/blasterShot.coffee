Q.Shot.extend 'BlasterShot',

  init: (p) ->
    @_super Q._extend
        asset: 'blasterShot.png'
        damage: 1
      , p

    @on "sensor", (otherEntity) ->
      Q.audio.play 'hit.mp3'
      @destroy()

  draw: (ctx) ->
    ctx.save()
    ctx.globalCompositeOperation = 'lighter'
    @_super(ctx)
    ctx.restore()

