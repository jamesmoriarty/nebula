Q = Quintus()                                       # create a new engine instance
  .include('Sprites, Scenes, Input, 2D, Touch, UI') # load any needed modules
  .setup(development: true, maximize: true)         # add a canvas element onto the page
  .controls()                                       # add in default controls (keyboard, buttons)
  .touch();                                         # add in touch support (for the UI)

Q.Sprite.extend 'Background',
  init: (p) ->
    @._super p,
      x: 0,
      y: 0,
      asset: 'background.png',
      type: 0

  draw: (ctx) ->
    ctx.drawImage @.asset(), 0, 0, @.asset().width, @.asset().height, 0, 0,  Q.width,  Q.height

Q.Sprite.extend 'Star',
  init: (p) ->
    @._super p,
      x: Math.random() * Q.width,
      y: Math.random() * Q.height,
      scale: Math.random()
      asset: 'star.png',
      type: 0

  update: (dt) ->
    if @.p.y > Q.height
      @.p.y = 0
    @.p.y += dt *  Math.pow(1000, @.p.scale)

Q.scene 'Menu', (stage) ->

  stage.insert(new Q.Background())

  stage.insert(new Q.Star()) for [1..250]

  stage.insert(new Q.UI.Text(
    label: 'Nebula',
    color: 'white',
    family: 'monospace'
    size: 48
    x: Q.width * (3 / 4),
    y: Q.height / 4
  ))

  stage.insert(new Q.UI.Button(
      label: 'New Game',
      x: Q.width * (3 / 4),
      y: Q.height / 2,
      fontColor: 'white',
      font: "400 24px monospace",
    , -> alert('Dat button Press')
  ))

# Q.debug = true
# Q.debugFill = true
Q.load([ 'spaceship.png', 'particle.png', 'background.png', 'star.png' ], ->
  Q.stageScene('Menu')
)

window.Q = Q
