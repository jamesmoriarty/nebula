Q.scene 'Game', (stage) ->
  player = new Q.SmallShip
    x: Q.center().x
    y: Q.center().y
  player.add("blaster")
  player.add("player")
  player.add("minimap")

  stage.insert new Q.Background target: player

  for [1..(Q.width * Q.height / 10000)]
    stage.insert new Q.Star target: player

  stage.insert player

  for [1..6]
    enemy = new Q.SmallShip
      angle: Math.random() * 360
      x: player.p.x + Math.random() * Q.random(-1000, 1000)
      y: player.p.y + Math.random() * Q.random(-1000, 1000)
    enemy.add("aiHunter")
    enemy.add("blaster")
    stage.insert enemy

    enemy.on 'destroyed', ->
      won = true
      Q._each Q("SmallShip").items, (ship) ->
        if ship.p.hp > 0 and ship.p.asset != player.p.asset
          won = false
      if won
        setTimeout ->
          Q.stageScene 'Menu'
        , 3000

  player.on 'destroyed', ->
    setTimeout ->
      Q.stageScene 'Menu'
    , 3000

  stage.add 'viewport'
  stage.follow(player, x: true, y: true)

