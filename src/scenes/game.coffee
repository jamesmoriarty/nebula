Q.scene 'Game', (stage) ->

  player = new Q.SmallShip
    angle: Math.random() * 360
    x:     Q.center().x
    y:     Q.center().y

  player.add("blaster")
  player.add("input")
  player.add("minimap")
  player.add("hud")

  stage.insert new Q.Background target: player

  for [1..(Q.width * Q.height / 10000)]
    stage.insert new Q.Star target: player

  stage.insert player

  for n in [1..6]
    radius = 1000
    theta  = Math.PI * 2 / 6 * n
    x      = player.p.x + radius * Math.cos theta
    y      = player.p.y + radius * Math.sin theta

    enemy  = new Q.SmallShip
      angle: Math.random() * 360
      x:     x
      y:     y

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
            Q.fadeOut ->
              Q.stageScene 'Menu'
              Q.fadeIn()
          , 3000

  player.on 'destroyed', ->
    setTimeout ->
        Q.fadeOut ->
          Q.stageScene 'Menu'
          Q.fadeIn()
      , 3000

  stage.add 'viewport'
  stage.follow(player, x: true, y: true)

  stage.on "postrender", (ctx) ->
    Q.fadeOpacity = Q.fadeOpacity or 0
    ctx.save()
    ctx.setTransform 1, 0, 0, 1, 0, 0
    ctx.translate 0, 0
    ctx.fillStyle="rgba(0,0,0,#{Q.fadeOpacity})"
    ctx.fillRect(0, 0, Q.width, Q.height)
    ctx.restore()

