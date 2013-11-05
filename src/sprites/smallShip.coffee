Q.Ship.extend 'SmallShip',

  init: (p) ->
    @_super Q._extend
        asset: "ship#{Math.floor((Math.random()*4)+1);}.png"
      , p

    @weapon = new Q.Blaster
,
  acceleration: 100
  rotation: 100
  maxVelocity: 200

