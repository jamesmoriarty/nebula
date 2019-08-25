Quintus.Util = (Q) ->

  Q.fadeIn = (callback, rate = 10) ->
    if Q.fadeOpacity != 0
      Q.fadeOpacity = Math.max(Q.fadeOpacity - 0.01, 0)
      clearTimeout(Q.fadeTimeoutId)
      Q.fadeTimeoutId = setTimeout ->
          Q.fadeIn(callback, rate)
        , rate
    else
      callback.call() if callback

  Q.fadeOut = (callback, rate = 10) ->
    if Q.fadeOpacity != 1
      Q.fadeOpacity = Math.min(Q.fadeOpacity + 0.01, 1)
      clearTimeout(Q.fadeTimeoutId)
      Q.fadeTimeoutId = setTimeout ->
          Q.fadeOut(callback, rate)
        , rate
    else
      callback.call() if callback

  Q.random = (min, max) ->
    Math.random() * ( max - min ) + min

  Q.center = ->
    { x: Q.width / 2, y: Q.height / 2 }

  Q.insideViewport = (entity) ->
    Q.insidePolygon [
        { x: Q.canvasToStageX(0,       Q.stage()), y: Q.canvasToStageY(0,        Q.stage()) },
        { x: Q.canvasToStageX(Q.width, Q.stage()), y: Q.canvasToStageY(0,        Q.stage()) },
        { x: Q.canvasToStageX(Q.width, Q.stage()), y: Q.canvasToStageY(Q.height, Q.stage()) },
        { x: Q.canvasToStageX(0,       Q.stage()), y: Q.canvasToStageY(Q.height, Q.stage()) }
      ], entity.p

  Q.insidePolygon = (points, p) ->
    c = false
    i = -1
    l = points.length
    j = l - 1

    while ++i < l
      ((points[i].y <= p.y and p.y < points[j].y) or (points[j].y <= p.y and p.y < points[i].y)) and (p.x < (points[j].x - points[i].x) * (p.y - points[i].y) / (points[j].y - points[i].y) + points[i].x) and (c = not c)
      j = i
    c
