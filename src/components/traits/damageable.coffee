Q.component 'damageable',

  added: ->
    @entity.on "draw", @, "draw"
    @entity.on "sensor",  @, "collision"

  collision: (otherEntity) ->
    if damage = otherEntity.p.damage
      @entity.p.hp = @entity.p.hp - damage
      otherEntity.p.damage = 0
    if @entity.p.hp <= 0
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

