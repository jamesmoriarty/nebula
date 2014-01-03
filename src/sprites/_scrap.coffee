MIN_SPIN_RATE = 2

Q.Sprite.extend 'Scrap',

  init: (p) ->
    @_super Q._extend
        asset: 'rock-2.png'
        ttl: 10000
        sensor: true
        type: Q.SPRITE_POWERUP
        collisionMask: Q.SPRITE_FRIENDLY
        z: 5
      , p

    @add '2d'
    @add 'ttl'

    @p.vx = @p.parent.vx
    @p.vy = @p.parent.vy
    @p.spinRate = ((@p.vx or 1) * (@p.vy or 1)) / 360

    @on "sensor", @, 'powerUp'

  powerUp: (collectingEntity) ->
    return unless resources = collectingEntity.p?.gatheredResources

    resources.scraps ?= 0
    resources.scraps += 1
    @destroy()

  draw: (ctx) ->
    ctx.save()
    ctx.globalCompositeOperation = 'lighter'
    ctx.fillStyle = '#00FF00'
    ctx.globalAlpha = 0.15
    ctx.beginPath()
    ctx.arc 0, 0, 30, 0, 2 * Math.PI
    ctx.fill()
    ctx.restore()

    @_super(ctx)

  stepTo: (from, inc, target = 0) ->
    return Math.min(from + inc, (target * -1)) if from < target
    Math.max(from - inc, target)

  step: (dt) ->
    @decaySpin()
    @decayVelocity()

  decaySpin: ->
    return if @p.spinRate == 0
    @p.spinRate = @stepTo @p.spinRate, 0.5, MIN_SPIN_RATE
    @p.angle += @p.spinRate

  decayVelocity: ->
    return if @p.vx == 0 and @p.vy == 0
    @p.vx = @stepTo @p.vx, 1, 0.2
    @p.vy = @stepTo @p.vy, 1, 0.2