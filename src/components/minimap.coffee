Q.component 'minimap',

  added: ->
    @entity.on "draw", @, "draw"

  draw: (ctx, width = 100, height = 100) ->
    centerX = width  / 2
    centerY = height / 2

    ctx.save()
    ctx.setTransform 1, 0, 0, 1, 0, 0
    ctx.translate 0, 0
    ctx.lineWidth="2"

    ctx.beginPath()
    ctx.strokeStyle = "#FFF"
    ctx.fillStyle   = "rgba(255,255,255,0.1)"
    ctx.rect 0, 0, width, height
    ctx.fill()
    ctx.stroke()

    ctx.beginPath()
    ctx.strokeStyle = "#00F"
    ctx.rect centerX, centerY, 1, 1
    ctx.stroke()

    _this = @entity
    ctx.beginPath()
    Q("SmallShip").each ->
      x = centerX - ((_this.p.x - @p.x) / 100)
      y = centerY - ((_this.p.y - @p.y) / 100)
      ctx.strokeStyle = "#F00"
      ctx.rect x, y, 1, 1
      ctx.stroke()

    ctx.restore()
