Q.Ship.extend 'SmallShip',

  init: (p) ->
    @_super Q._extend
        asset: "ship#{Math.floor((Math.random()*4)+1);}.png"
      , p
,
  acceleration: 100
  rotation: 150
  maxVelocity: 250

