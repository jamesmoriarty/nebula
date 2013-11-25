Q.Ship.extend 'SmallShip',

  init: (p) ->
    @_super Q._extend
        asset: "ship#{Math.floor((Math.random()*3)+1);}.png"
      , p

      @on 'damaged', (otherEntity) ->
        @stage.insert new Q.ShieldFlare
          x:  @p.x
          y:  @p.y
          vx: @p.vx
          vy: @p.vy
          angle: otherEntity.p.angle - 180

,
  acceleration: 100
  rotation: 150
  maxVelocity: 250

