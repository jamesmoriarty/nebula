Q.component 'aiHunter',

  added: ->
    @entity.on "step", @, "step"

  step: (dt) ->
    target = @search()

    if target
      targetAngle = @entity.p.angle - Q.angle @entity.p.x, @entity.p.y, target.p.x, target.p.y
      if targetAngle > 0
        @entity.turn dt, -Q[@entity.className].rotation
      else
        @entity.turn dt,  Q[@entity.className].rotation

      targetDistance = Q.distance @entity.p.x, @entity.p.y, target.p.x, target.p.y
      if Math.abs(targetAngle) < 10 and targetDistance < 200
        @entity.fire()

      @entity.accelerate dt

  search: (target = null) ->
    _this = @entity
    best = null

    targets = Q("SmallShip").items

    targets = Q._map targets, (target) ->
        distance: Q.distance _this.p.x, _this.p.y, target.p.x, target.p.y
        asset: target.p.asset
        object: target

    targets = Q._each targets, (target) ->
      if target.object != _this and target.asset != _this.p.asset and (!best or best.distance > target.distance)

        best = target

    best and best.object

