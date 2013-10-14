Q.Sprite.extend 'MenuBackground',
  init: (p) ->
    @_super p,
      x: 0
      y: 0
      asset: 'background.png'
      type: Q.SPRITE_NONE

  draw: (ctx) ->
    ctx.drawImage @asset(), 0, 0, @asset().width, @asset().height, 0, 0,  Q.width,  Q.height

