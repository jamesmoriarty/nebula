Q.scene 'Menu', (stage) ->
  color = 'white'
  x     = Q.width * (3 / 4)

  stage.insert new Q.Background target: null

  stage.insert new Q.MenuStar for [1..(Q.width * Q.height / 10000)]

  stage.insert new Q.UI.Text
    label: 'Nebula'
    x: x
    y: Q.height / 4
    color: color
    family: 'ui'
    size: 56

  stage.insert new Q.UI.Button
    label: 'New Game'
    x: x
    y: Q.height / 4 * 2
    fontColor: color
    font: '400 24px ui'
    , ->
      Q.fadeOut ->
        Q.stageScene 'Game'
        Q.fadeIn()

  if !Q.touchDevice
    button = new Q.UI.Button
      label: "Mouse Toggle"
      x: x
      y: Q.height / 4 * 3
      fontColor: color
      font: '400 24px ui'
      , -> Q.mouseEnabled = !Q.mouseEnabled

    Object.defineProperty button.p, 'label',
      get: ->
        "#{if Q.mouseEnabled then "Disable" else "Enable"} Mouse"

    stage.insert button

  stage.on "postrender", (ctx) ->
    Q.fadeOpacity = Q.fadeOpacity or 0
    ctx.save()
    ctx.setTransform 1, 0, 0, 1, 0, 0
    ctx.translate 0, 0
    ctx.fillStyle="rgba(0,0,0,#{Q.fadeOpacity})"
    ctx.fillRect(0, 0, Q.width, Q.height)
    ctx.restore()
