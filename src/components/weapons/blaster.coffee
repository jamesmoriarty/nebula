Q.components['blaster'] = Q.Weapon.extend "Blaster",

  fire: ->
    velocity = Q[@className].velocity
    angle    = @entity.p.angle

    @entity.stage.insert new Q.BlasterShot
      x:  @entity.p.x +  Q.offsetX(angle, @entity.p.cx)
      y:  @entity.p.y +  Q.offsetY(angle, @entity.p.cy)
      vx: @entity.p.vx + Q.offsetX(angle, velocity)
      vy: @entity.p.vy + Q.offsetY(angle, velocity)
      angle: angle

    Q.audio.play 'blasterShot.mp3'
,
  coolDown: 200
  velocity: 750

