Q.scene 'Game', (stage) ->

  x = Q.center().x
  y = Q.center().y
  player = new Q.Player x: x, y: y
  stage.insert new Q.Star player: player for [1..(Q.width * Q.height / 10000)]
  stage.insert player

  stage.on 'destroy', ->
    player.destroy

  stage.add('viewport')
  stage.follow(player, x: true, y: true)

