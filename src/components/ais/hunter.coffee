Q.component 'aiHunter',

  added: ->
    @entity.on "step", @, "step"

  step: (dt) ->
    @entity.trigger 'up', dt

    if target = @search()

      targetAngle = Q.normalizeAngle(@entity.p.angle - Q.angle @entity.p.x, @entity.p.y, target.p.x, target.p.y)
      if targetAngle > 180
        @entity.trigger 'left', dt
      else
        @entity.trigger 'right', dt

      targetDistance = Q.distance @entity.p.x, @entity.p.y, target.p.x, target.p.y
      if targetAngle > 170 and targetAngle < 190 and targetDistance < 200
        @entity.trigger 'fire'


  search: (option = null, best = null, _this = @entity) ->
    Q._each Q("SmallShip").items, (option) ->
        option =
          distance: Q.distance _this.p.x, _this.p.y, option.p.x, option.p.y
          asset: option.p.asset
          object: option

        if option.object != _this and option.asset != _this.p.asset and (!best or best.distance > option.distance)
          best = option

    best and best.object

