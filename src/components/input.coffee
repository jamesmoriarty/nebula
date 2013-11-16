Q.component 'input',

  added: ->
    @entity.on "step", @, "step"

  step: (dt) ->
    if Q.inputs['fire']
      @entity.trigger 'fire'

    if Q.inputs['up'] or Q.inputs['action']
      @entity.trigger 'up', dt

    if Q.inputs['left']
      @entity.trigger 'left', dt

    if Q.inputs['right']
      @entity.trigger 'right', dt

