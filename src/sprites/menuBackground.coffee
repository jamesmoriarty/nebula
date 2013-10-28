Q.Sprite.extend 'MenuBackground',
  init: (p) ->
    @_super p,
      x: 0
      y: 0
      asset: 'background.png'
      type: Q.SPRITE_NONE

  draw: (ctx) ->
    if @stage.viewport
      ctx.drawImage @asset(), 0, 0, @asset().width, @asset().height, @stage.viewport.centerX - Q.width / 2, @stage.viewport.centerY - Q.height / 2,  Q.width,  Q.height
