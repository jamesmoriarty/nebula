make:
	coffee --join nebula.js -o js/ -cw src/
server:
	# ruby -run -e httpd . -p3000
	python -m SimpleHTTPServer 3000
run:
	make &
	make server &
	open http://localhost:3000/index.html

