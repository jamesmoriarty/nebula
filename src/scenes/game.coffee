Q.scene 'Game', (stage) ->
  player = new Q.Player
    x: Q.center().x
    y: Q.center().y

  stage.insert new Q.Background target: player

  stage.insert new Q.Star target: player for [1..(Q.width * Q.height / 10000)]

  stage.insert new Q.Enemy x: player.p.x, y: player.p.y

  stage.insert player

  stage.on 'destroy', ->
    player.destroy

  stage.add 'viewport'
  stage.follow(player, x: true, y: true)

