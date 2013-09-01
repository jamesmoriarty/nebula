Q.Sprite.extend 'MenuStar',
  init: (p) ->
    @._super p,
      x: Math.random() * Q.width
      y: Math.random() * Q.height
      scale: Math.random()
      asset: 'star.png'
      type: Q.SPRITE_NONE

  update: (dt) ->
    if @.p.y > Q.height
      @.p.y = 0
      @.p.x = Math.random() * Q.width
    @.p.y += dt *  Math.pow(1000, @.p.scale)

