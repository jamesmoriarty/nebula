Q.Sprite.extend 'Star',
  init: (p) ->
    @_super p,
      player: p.player
      x: Math.random() * Q.width
      y: Math.random() * Q.height
      asset: 'star.png'
      scale: Math.random()
      type: Q.SPRITE_NONE

    @add('2d')

  step: (dt) ->
    @p.vx = @p.player.p.vx * (@p.scale / -1)
    @p.vy = @p.player.p.vy * (@p.scale / -1)
    if Math.abs(@p.x - @p.player.p.x) > Q.width or Math.abs(@p.y - @p.player.p.y) > Q.height
      @p.x = Q.stage().viewport.x + (Math.random() * Q.width)
      @p.y = Q.stage().viewport.y + (Math.random() * Q.height)
