Q.Weapon = Q.Class.extend "Weapon",
  init: ->
    @lastFired = 0

  tryFire: (from) ->
    now = new Date().getTime()
    if now > @lastFired + Q[this.className].coolDown
      @fire(from)
      @lastFired = now

Q.Weapon.extend "Blaster",

  fire: (from) ->
    velocity = Q[this.className].velocity
    accuracy = Math.floor((Math.random() * 5) - 5)
    angle    = from.p.angle + accuracy

    from.stage.insert new Q.BlasterShot
      x:  from.p.x + Q.offsetX(from.p.angle, from.p.cx * 2)
      y:  from.p.y + Q.offsetY(from.p.angle, from.p.cy * 2)
      vx: from.p.vx + Q.offsetX(angle, velocity)
      vy: from.p.vy + Q.offsetY(angle, velocity)
      angle: angle

    Q.audio.play('blasterShot.mp3')
,
  coolDown: 100
  velocity: 500

Q.Sprite.extend 'BlasterShot',
  init: (p) ->
    @_super p,
      asset: 'particle.png'
      z: 5
      scale: 0.4

    @add('2d')

