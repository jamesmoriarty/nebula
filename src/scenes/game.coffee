Q.scene 'Game', (stage) ->
  player = new Q.SmallShip
    x: Q.center().x
    y: Q.center().y
  player.add("player")
  player.add("minimap")

  stage.insert new Q.Background target: player

  for [1..(Q.width * Q.height / 10000)]
    stage.insert new Q.Star target: player

  stage.insert player

  for [1..9]
    enemy = new Q.SmallShip
      x: player.p.x + Math.random() * Q.random(-1000, 1000)
      y: player.p.y + Math.random() * Q.random(-1000, 1000)
    enemy.add("aiHunter")
    stage.insert enemy

  player.on 'destroyed', ->
    Q.stageScene 'Menu'

  stage.add 'viewport'
  stage.follow(player, x: true, y: true)

