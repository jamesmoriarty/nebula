Q.Sprite.extend 'Background',

  init: (p) ->
    @_super p,
      target: p.target
      x: 0
      y: 0
      asset: 'background.png'
      type: Q.SPRITE_NONE

  drawOffset: 200

  draw: (ctx) ->
    if @stage.viewport
      offsetX = @stage.viewport.centerX - Q.width / 2
      offsetY = @stage.viewport.centerY - Q.height / 2
    else
      offsetX = 0
      offsetY = 0

    if @p.target
      offsetX += (- @p.target.p.vx / 10)
      offsetY += (- @p.target.p.vy / 10)

    ctx.drawImage @asset(),
      0,
      0,
      @asset().width,
      @asset().height,
      offsetX  - @drawOffset,
      offsetY  - @drawOffset,
      Q.width  + @drawOffset * 2,
      Q.height + @drawOffset * 2

