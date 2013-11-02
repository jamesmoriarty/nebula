Q.Ship.extend 'Enemy',

  init: (p) ->
    @_super Q._extend
        type: Q.SPRITE_DEFAULT | Q.SPRITE_ENEMY
        collisionMask: Q.SPRITE_ACTIVE
        asset: 'enemy.png'
      , p

    @add('aiWander')

,
  acceleration: 50
  rotation: 100
  maxVelocity: 100

