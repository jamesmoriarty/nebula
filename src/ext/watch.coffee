unless Object::watch
  Object.defineProperty Object::, "watch",
    enumerable: false
    configurable: true
    writable: false
    value: (prop, handler) ->
      oldval = @[prop]
      newval = oldval
      getter = ->
        newval
      setter = (val) ->
        oldval = newval
        newval = handler.call(@, prop, oldval, val)
      if delete @[prop]
        Object.defineProperty @, prop,
          get: getter
          set: setter
          enumerable: true
          configurable: true

unless Object::unwatch
  Object.defineProperty Object::, "unwatch",
    enumerable: false
    configurable: true
    writable: false
    value: (prop) ->
      val = @[prop]
      delete @[prop]
      @[prop] = val

