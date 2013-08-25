Quintus.NebulaSprites = (Q) ->

  Q.Sprite.extend 'Background',
    init: (p) ->
      @._super p,
        x: 0,
        y: 0,
        asset: 'background.png',
        type: 0

    draw: (ctx) ->
      ctx.drawImage @.asset(), 0, 0, @.asset().width, @.asset().height, 0, 0,  Q.width,  Q.height

  Q.Sprite.extend 'Star',
    init: (p) ->
      @._super p,
        x: Math.random() * Q.width,
        y: Math.random() * Q.height,
        scale: Math.random()
        asset: 'star.png',
        type: 0

    update: (dt) ->
      if @.p.y > Q.height
        @.p.y = 0
      @.p.y += dt *  Math.pow(1000, @.p.scale)

