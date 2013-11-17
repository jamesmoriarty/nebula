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
    , -> Q.stageScene 'Game'

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

