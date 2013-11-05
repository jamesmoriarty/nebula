Q = Quintus()                                                           # create a new engine instance
  .include('Util, Math, Sprites, Scenes, Input, 2D, Touch, UI, Audio')  # load any needed modules
  .setup(development: true, maximize: true)                             # add a canvas element onto the page
  .controls()                                                           # add in default controls (keyboard, buttons)
  .touch()                                                              # add in touch support (for the UI)
  .enableSound()

Q.gravityY = 0
Q.gravityX = 0
Q.clearColor = "#000"
#Q.debug = true
#Q.debugFill = true

Q.load [
    'ship1.png',
    'ship2.png',
    'ship3.png',
    'ship4.png',
    'ship5.png',
    'particle.png',
    'blasterShot.png',
    'background.png',
    'star.png',
    'hit.mp3',
    'blasterShot.mp3'
  ], ->
    Q.stageScene('Menu')
  , progressCallback: (loaded, total) ->
    percent_loaded = Math.floor(loaded / total * 100)
    document.getElementById('loading_progress').style.width = percent_loaded + '%'

window.Q = Q

#document.addEventListener "click", ->
#  e = document.getElementById("quintus")
#  if e.webkitRequestFullScreen
#    e.webkitRequestFullScreen()

