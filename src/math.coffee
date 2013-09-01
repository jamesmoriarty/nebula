Quintus.Math = (Q) ->

  Q.offsetX = (angle, radius) ->
    Math.sin(angle / 180 * Math.PI) * radius

  Q.offsetY = (angle, radius) ->
    - Math.cos(angle / 180 * Math.PI) * radius

