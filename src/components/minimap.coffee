Q.component 'minimap',

  added: ->
    @entity.on "draw", @, "draw"

  draw: (ctx, width = 150, height = 150) ->
    maxX = 0
    maxY = 0

    _this = @entity
    Q("SmallShip").each ->
      diffX = Math.abs(_this.p.x - this.p.x)
      maxX  = diffX if diffX > maxX
      diffY = Math.abs(_this.p.y - this.p.y)
      maxY  = diffY if diffY > maxY

    scale = Math.min(width / maxX, height / maxY) / 2.1

    centerX = width  / 2
    centerY = height / 2

    ctx.save()
    ctx.setTransform 1, 0, 0, 1, 0, 0
    ctx.translate 0, 0
    ctx.lineWidth="2"

    ctx.beginPath()
    ctx.strokeStyle = "rgba(255,255,255,0.25)"
    ctx.fillStyle   = "rgba(255,255,255,0.1)"
    ctx.rect 0, 0, width, height
    ctx.fill()
    ctx.stroke()

    _this = @entity
    Q("SmallShip").each ->
      if @ != _this
        ctx.beginPath()
        ctx.strokeStyle = if @.p.asset == _this.p.asset then "#0F0" else "#F00"
        x = centerX - ((_this.p.x - @p.x) * scale)
        y = centerY - ((_this.p.y - @p.y) * scale)
        ctx.rect x, y, 1, 1
        ctx.stroke()

    ctx.save()
    ctx.beginPath()
    ctx.font      = "400 14px ui"
    text          = "SCALE: x1/#{Math.round(1/scale)}"
    metrics       = ctx.measureText(text)
    ctx.fillStyle = "rgba(255,255,255,0.5)"
    ctx.fillText text, width / 2 - metrics.width / 2, height + 5
    ctx.restore()

    ctx.beginPath()
    ctx.strokeStyle = "#00F"
    ctx.rect centerX, centerY, 1, 1
    ctx.stroke()
    ctx.restore()
