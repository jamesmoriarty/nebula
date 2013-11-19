Quintus.Util = (Q) ->

  Q.random = (min, max) ->
    Math.random() * ( max - min ) + min

  Q.center = ->
    { x: Q.width / 2, y: Q.height / 2 }

  Q.insideViewport = (entity) ->
    stage = Q.stage()
    polygon = [
      { x: Q.canvasToStageX(0,       stage), y: Q.canvasToStageY(0,        stage) },
      { x: Q.canvasToStageX(Q.width, stage), y: Q.canvasToStageY(0,        stage) },
      { x: Q.canvasToStageX(Q.width, stage), y: Q.canvasToStageY(Q.height, stage) },
      { x: Q.canvasToStageX(0,       stage), y: Q.canvasToStageY(Q.height, stage) }
    ]

    Q.insidePolygon(polygon, entity.p)

  Q.insidePolygon = (poly, pt) ->
    c = false
    i = -1
    l = poly.length
    j = l - 1

    while ++i < l
      ((poly[i].y <= pt.y and pt.y < poly[j].y) or (poly[j].y <= pt.y and pt.y < poly[i].y)) and (pt.x < (poly[j].x - poly[i].x) * (pt.y - poly[i].y) / (poly[j].y - poly[i].y) + poly[i].x) and (c = not c)
      j = i
    c
