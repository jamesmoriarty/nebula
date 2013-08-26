make:
	coffee --join nebula.js -o js/ -cw src/
server:
	ruby -run -e httpd . -p3000

