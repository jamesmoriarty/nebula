Quintus.Util = (Q) ->

  Q.random = (min, max) ->
    Math.random() * ( max - min ) + min

  Q.center = ->
    { x: Q.width / 2, y: Q.height / 2 }

