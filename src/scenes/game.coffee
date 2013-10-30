Q.scene 'Game', (stage) ->
  player = new Q.Player
    x: Q.center().x
    y: Q.center().y

  stage.insert new Q.Background target: player

  stage.insert new Q.Star target: player for [1..(Q.width * Q.height / 5000)]

  stage.insert player

  stage.on 'destroy', ->
    player.destroy

  stage.add('viewport')
  stage.follow(player, x: true, y: true)

