help:
	@echo "make console"

console:
	irb -r rubygems -I lib -r zoom.rb