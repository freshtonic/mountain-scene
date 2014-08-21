
SRC_COFFEE  = $(shell find src -name \*.coffee)
TARGET_JS 	= $(subst src/, build/, $(addsuffix .js, $(basename $(SRC_COFFEE))))

SPEC_COFFEE = $(shell find spec/ -name \*.coffee)
SPEC_JS 	= $(subst spec/, build/, $(addsuffix .js, $(basename $(SPEC_COFFEE))))

DIST = dist/mountain-scene.js

# RULES

build/%.js: src/%.coffee
	@echo COMPILE: $<
	@node_modules/coffee-script/bin/coffee --nodejs --no-deprecation  -o $(subst src, build, $(dir $@)) -c $<

build/%.js: spec/%.coffee
	@echo COMPILE: $<
	@node_modules/coffee-script/bin/coffee --nodejs --no-deprecation  -o $(subst src, build, $(dir $@)) -c $<

# TARGETS

$(DIST): $(TARGET_JS)
	@cat $^ > $@

# TASKS

compile: $(DIST)

spec: $(DIST) $(SPEC_JS)
	@echo SPEC: $(SPEC_JS)
	@node_modules/jasmine-node/bin/jasmine-node $(SPEC_JS)

clean:
	@rm -fr build/*

watch-compile: compile
	@wach -o src/*.coffee, make compile

watch: spec compile
	@wach -o src/*.coffee,spec/*.coffee, make compile spec

all: compile spec

.PHONY: all compile spec clean watch

.DEFAULT: all

