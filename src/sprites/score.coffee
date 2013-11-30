Q.UI.Text.extend "Score",
  init: ->
    @_super
      label: "SCORE: 0"

    Q.state.on "change.score", @, "score"

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

  score: (score) ->
    @p.label = "SCORE: " + score
