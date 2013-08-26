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

