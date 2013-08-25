Quintus.NebulaScenes = (Q) ->

  Q.scene 'Menu', (stage) ->

    stage.insert(new Q.Background())

    stage.insert(new Q.Star()) for [1..250]

    stage.insert(new Q.UI.Text(
      label: 'Nebula',
      color: 'white',
      family: 'monospace'
      size: 48
      x: Q.width * (3 / 4),
      y: Q.height / 4
    ))

    stage.insert(new Q.UI.Button(
        label: 'New Game',
        x: Q.width * (3 / 4),
        y: Q.height / 2,
        fontColor: 'white',
        font: "400 24px monospace",
      , -> alert('Dat button Press')
    ))

    stage.insert(new Q.UI.Button(
        label: 'New Game',
        x: Q.width * (3 / 4),
        y: Q.height / 2,
        fontColor: 'white',
        font: "400 24px monospace",
      , -> alert('Dat button Press')
    ))

