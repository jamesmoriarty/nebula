Q.Sprite.extend 'Star',
  init: (p) ->
    @._super p,
      player: p.player
      x: Math.random() * Q.width
      y: Math.random() * Q.height
      scale: Math.random()
      asset: 'star.png'
      type: Q.SPRITE_NONE

  update: (dt) ->
    @.p.vx = Math.pow(@.p.player.p.vx, Q.width)
    @.p.vy = Math.pow(@.p.player.p.vy, Q.width)
    if Math.abs(@.p.x - @.p.player.p.x) > Q.width or Math.abs(@.p.y - @.p.player.p.y) > Q.height
      @.p.x = Q.stage().viewport.x + (Math.random() * Q.width)
      @.p.y = Q.stage().viewport.y + (Math.random() * Q.height)
