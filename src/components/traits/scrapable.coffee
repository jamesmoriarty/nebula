Q.component 'scrapable',
  added: ->
    @entity.on 'destroyed', @, 'scrap'

  scrap: ->
    scrap = new Q.Scrap
      x: @entity.p.x
      y: @entity.p.y
      parent: @entity.p

    Q.stage().insert scrap