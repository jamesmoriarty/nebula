Q.component 'ttl',

  added: ->
    @startedAt = @now()
    @entity.on "step", @, "step"

  step: ->
    if @now() > @startedAt + @entity.p.ttl
      @entity.destroy()

  now: ->
    new Date().getTime()

