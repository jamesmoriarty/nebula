Q.component 'damageable',

  added: ->
    @entity.on "draw", @, "draw"
    @entity.on "hit",  @, "collision"

  collision: (col) ->
    if damage = col.obj.p.damage
      @entity.p.hp = @entity.p.hp - damage
    if @entity.p.hp <= 0
      if col.obj.container
        Q.stage().follow(col.obj.container, x: true, y: true)
      @entity.destroy()

  draw: (ctx) ->
    if @entity.p.hp and @entity.p.maxHp
      ctx.save()
      ctx.beginPath()
      ctx.font      = "400 14px ui"
      text          = "#{Math.round(@entity.p.hp / @entity.p.maxHp * 100)}%"
      metrics       = ctx.measureText(text)
      ctx.fillStyle = "#FFF"
      ctx.rotate Q.degreesToRadians(-@entity.p.angle)
      ctx.fillText text, -metrics.width / 2, -50
      ctx.restore()

