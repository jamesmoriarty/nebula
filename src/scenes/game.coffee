Q.scene 'Game', (stage) ->

  player = new Q.Player x: Q.width / 2, y: Q.height / 2
  stage.insert new Q.Star player: player for [1..(Q.width * Q.height / 10000)]
  stage.insert player

  stage.on 'destroy', ->
    player.destroy

  stage.add('viewport')
  stage.follow(player, x: true, y: true)

