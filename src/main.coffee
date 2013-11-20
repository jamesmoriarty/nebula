Q = Quintus()                                                           # create a new engine instance
  .include('Util, Math, Sprites, Scenes, Input, 2D, Touch, UI, Audio')  # load any needed modules
  .setup(development: true, maximize: true)                             # add a canvas element onto the page
  .controls()                                                           # add in default controls (keyboard, buttons)
  .touch()                                                              # add in touch support (for the UI)
  .enableSound()

Q.gravityY = 0
Q.gravityX = 0
Q.clearColor = "#000"
# Q.debug = true
# Q.debugFill = true

Q.input.keys[87] = 'up'
Q.input.keys[65] = 'left'
Q.input.keys[68] = 'right'

Q.load [
    'ship1.png',
    'ship2.png',
    'ship3.png',
    'ship4.png',
    'particle.png',
    'blasterShot.png',
    'blasterShot.mp3',
    'rocketShot.png',
    'rocketShot.mp3'
    'background.png',
    'star.png',
    'hit.mp3',
    'exp.mp3',
  ], ->
    Q.stageScene('Menu')
  , progressCallback: (loaded, total) ->
    percent_loaded = Math.floor(loaded / total * 100)
    document.getElementById('loading_progress').style.width = percent_loaded + '%'

window.Q = Q

document.body.onmousedown = (event) ->
  Q.inputs['mouse']  = true

document.body.onmouseup = (event) ->
  delete Q.inputs['mouse']

last = {}
document.body.onmousemove = (event) ->
  last.x = event.x
  last.y = event.y

setInterval ->
    if last.x and last.y
      if Q.stage()
        Q.inputs['mouseX'] = Q.canvasToStageX last.x, Q.stage()
        Q.inputs['mouseY'] = Q.canvasToStageY last.y, Q.stage()
  , 50

#document.addEventListener "click", ->
#  e = document.getElementById("quintus")
#  if e.webkitRequestFullScreen
#    e.webkitRequestFullScreen()

