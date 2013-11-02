Quintus.Math = (Q) ->

  Q.normalizeAngle = (angle) ->
    result = angle % 360

    if result < 0
      result + 360
    else
      result

  Q.angle = (fromX, fromY, toX, toY) ->
    distX   = toX - fromX
    distY   = toY - fromY
    radians = Math.atan2 distY, distX

    90 + Q.normalizeAngle(Q.radiansToDegrees(radians))

  Q.distance = (fromX, fromY, toX = 0, toY = 0) ->
    Math.sqrt Math.pow(fromX - toX, 2) + Math.pow(fromY - toY, 2)

  Q.offsetX = (angle, radius) ->
    Math.sin(angle / 180 * Math.PI) * radius

  Q.offsetY = (angle, radius) ->
    - Math.cos(angle / 180 * Math.PI) * radius

  Q.degreesToRadians = (degrees) ->
    degrees * (Math.PI / 180)

  Q.radiansToDegrees = (radians) ->
    radians * (180 / Math.PI)

