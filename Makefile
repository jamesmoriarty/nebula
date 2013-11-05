compile:
	# for file in audio/*.mp3; do `ffmpeg -i $file audio/$(basename ${file} .mp3).ogg`;done
	coffee --join nebula.js --output js/ --watch --compile src/modules/* src/main.coffee src/components/ src/sprites/ src/scenes/ &
server:
	# ruby -run -e httpd . -p3001
	# python -m SimpleHTTPServer 3001
	http-server . -p 3001 &
open:
	open http://localhost:3001/index.html
run: compile server open

