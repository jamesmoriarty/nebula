Q.component 'gatherer',

  added: ->
    @entity.p.gatheredResources ?= {}
    @entity.on "draw", @, "draw"

  draw: (ctx) ->
    for type, number of @entity.p.gatheredResources
      ctx.save()
      ctx.beginPath()
      ctx.font      = "400 14px ui"
      text          = "#{number} #{type} gathered"
      metrics       = ctx.measureText(text)
      ctx.fillStyle = "#FFF"
      ctx.rotate Q.degreesToRadians(-@entity.p.angle)
      ctx.fillText text, -metrics.width / 2, 50
      ctx.restore()

