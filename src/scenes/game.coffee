Q.scene 'Game', (stage) ->
  stage.insert new Q.Background

  x = Q.center().x
  y = Q.center().y
  player = new Q.Player x: x, y: y
  stage.insert player
  stage.insert new Q.Star player: player for [1..(Q.width * Q.height / 5000)]

  stage.on 'destroy', ->
    player.destroy

  stage.add('viewport')
  stage.follow(player, x: true, y: true)

