
SRC_COFFEE  = $(shell find src -name \*.coffee)

DIST = dist/mountain-scene.js

# RULES

build/%.js: src/%.coffee
	@echo COMPILE: $<
	@node_modules/coffee-script/bin/coffee --nodejs --no-deprecation  -o $(subst src, build, $(dir $@)) -c $<

# TARGETS

build/concat-order.txt: $(SRC_COFFEE)
	@./dep-order > $@

build/mountain-scene.coffee: build/concat-order.txt
	@cat $(shell cat $^) > $@

$(DIST): build/mountain-scene.coffee
	@echo COMPILE: $<
	@node_modules/coffee-script/bin/coffee --nodejs --no-deprecation  -o $(dir $@) -c $<

# TASKS

compile: $(DIST)

clean:
	@rm -fr build/* dist/*

watch: compile
	@wach -o src/*.coffee, make compile

all: compile

.PHONY: all compile clean watch

.DEFAULT: all

