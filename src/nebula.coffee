Q = Quintus()                                       # create a new engine instance
  .include('Sprites, Scenes, Input, 2D, Touch, UI') # load any needed modules
  .include('NebulaSprites, NebulaScenes')
  .setup(development: true, maximize: true)         # add a canvas element onto the page
  .controls()                                       # add in default controls (keyboard, buttons)
  .touch();                                         # add in touch support (for the UI)

# Q.debug = true
# Q.debugFill = true
Q.load([ 'spaceship.png', 'particle.png', 'background.png', 'star.png' ], ->
  Q.stageScene('Menu')
)

window.Q = Q
