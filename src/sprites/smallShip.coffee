Q.Ship.extend 'SmallShip',

  init: (p) ->
    @_super Q._extend
        type: Q.SPRITE_DEFAULT | Q.SPRITE_ENEMY
        collisionMask: Q.SPRITE_ACTIVE
        asset: "ship#{Math.floor((Math.random()*5)+1);}.png"
      , p

    @weapon = new Q.Blaster
,
  acceleration: 100
  rotation: 100
  maxVelocity: 200

