Q.Weapon = Q.Class.extend "Weapon",

  init: ->
    @lastFired = 0

  tryFire: (from) ->
    now = new Date().getTime()
    if now > @lastFired + Q[this.className].coolDown
      @fire(from)
      @lastFired = now

