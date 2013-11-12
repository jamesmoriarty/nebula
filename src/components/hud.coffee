Q.component 'hud',

  added: ->
    @entity.on "postdraw", @, "draw"

  draw: (ctx) ->
    _this = @entity
    Q("SmallShip").each ->
      if @ != _this
        if !@p.points
          Q._generatePoints @
        ctx.save()
        @matrix.setContextTransform ctx
        ctx.scale(2,2)
        ctx.beginPath()
        ctx.lineWidth = 2
        ctx.strokeStyle = if @p.asset == _this.p.asset then "rgba(0,255,0,0.25)" else "rgba(255,0,0,0.25)"
        ctx.moveTo @p.points[0][0], @p.points[0][1]
        i = 0
        while i < @p.points.length
          ctx.lineTo @p.points[i][0], @p.points[i][1]
          i++
        ctx.lineTo @p.points[0][0], @p.points[0][1]
        ctx.stroke()
        ctx.restore()

