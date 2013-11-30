Q.UI.Text.extend "Level",

  init: ->
    @_super
      label: "Level 1"

    Q.state.on "change.level", @, "level"

  draw: (ctx) ->
    ctx.save()
    ctx.setTransform 1, 0, 0, 1, 0, 0
    ctx.translate 0, 0
    ctx.beginPath()
    ctx.font      = "400 24px ui"
    metrics       = ctx.measureText(@p.label)
    ctx.fillStyle = "#FFF"
    ctx.fillText @p.label, (Q.width / 2) - (metrics.width / 2), 50
    ctx.restore()

  level: (level) ->
    @p.label = "Level " + level
