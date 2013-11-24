Q.components['machineGun'] = Q.Weapon.extend "MachineGun",

  fire: ->
    velocity = Q[@className].velocity
    angle    = @entity.p.angle

    @entity.stage.insert new Q.BlasterShot
      x:  @entity.p.x +  Q.offsetX(angle, Math.max(@entity.p.w, @entity.p.h) * 1.3)
      y:  @entity.p.y +  Q.offsetY(angle, Math.max(@entity.p.w, @entity.p.h) * 1.3)
      vx: @entity.p.vx + Q.offsetX(angle, velocity)
      vy: @entity.p.vy + Q.offsetY(angle, velocity)
      angle: angle

    Q.audio.play 'muzzleShot.mp3'
,
  coolDown: 20
  velocity: 750

