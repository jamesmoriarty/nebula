compile:
	# find . -name '*.coffee'
	# for file in audio/*.mp3; do `ffmpeg -i $file audio/$(basename ${file} .mp3).ogg`;done
	yarn install
	mkdir -p js
	cat \
		src/modules/util.coffee \
		src/modules/math.coffee \
		src/main.coffee \
		src/scenes/game.coffee \
		src/scenes/menu.coffee \
		src/components/traits/ttl.coffee \
		src/components/traits/damageable.coffee \
		src/components/input.coffee \
		src/components/hud.coffee \
		src/components/ais/hunter.coffee \
		src/components/ais/wander.coffee \
		src/components/weapons/_weapon.coffee \
		src/components/weapons/blaster.coffee \
		src/components/minimap.coffee \
		src/sprites/_ship.coffee \
		src/sprites/_shot.coffee \
		src/sprites/_shieldFlare.coffee \
		src/sprites/_particle.coffee \
		src/sprites/_particle.coffee \
		src/sprites/star.coffee \
		src/sprites/menuStar.coffee \
		src/sprites/blasterShot.coffee \
		src/sprites/level.coffee \
		src/sprites/background.coffee \
		src/sprites/smallShip.coffee | yarn --silent run coffee --no-header --compile --stdio > js/nebula.js
server:
	# ruby -run -e httpd . -p3001 &
	# python -m SimpleHTTPServer 3001
	yarn run http-server . -p 3001 
open:
	open http://localhost:3001/index.html
run: compile server open

