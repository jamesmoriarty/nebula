Q.Weapon = Q.component 'weapon',

  lastFired: 0

  added: ->
    @entity.on 'fire', @, 'tryFire'

  tryFire: ->
    now = new Date().getTime()
    if now > @lastFired + Q[@className].coolDown
      @fire()
      @lastFired = now

