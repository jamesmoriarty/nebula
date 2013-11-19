Q.components['blaster'] = Q.Weapon.extend "RocketLauncher",

  fire: ->
    velocity = Q[@className].velocity
    angle    = @entity.p.angle

    @entity.stage.insert new Q.RocketShot
      x:  @entity.p.x  + Q.offsetX(angle, Math.max(@entity.p.w, @entity.p.h) * 1.3)
      y:  @entity.p.y  + Q.offsetY(angle, Math.max(@entity.p.w, @entity.p.h) * 1.3)
      vx: @entity.p.vx
      vy: @entity.p.vy
      ax: Q.offsetX(angle, 1000)
      ay: Q.offsetY(angle, 1000)
      angle: angle

    Q.audio.play 'rocketShot.mp3'
,
  coolDown: 1000
  velocity: 500


