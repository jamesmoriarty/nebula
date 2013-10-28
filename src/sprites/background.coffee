Q.Sprite.extend 'Background',
  init: (p) ->
    @_super p,
      x: 0
      y: 0
      asset: 'background.png'
      type: Q.SPRITE_NONE

  draw: (ctx) ->
    if @stage.viewport
      offsetX = @stage.viewport.centerX - Q.width / 2
      offsetY = @stage.viewport.centerY - Q.height / 2
    else
      offsetX = 0
      offsetY = 0

    ctx.drawImage @asset(), 0, 0, @asset().width, @asset().height, offsetX, offsetY, Q.width, Q.height
