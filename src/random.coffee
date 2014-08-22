
# depends: app.module

# Generates a random number. However, we can resetthe seed so we can get
# repeatable random sequences. This is useful when tweaking generated mountains
# with different parameters.

angular.module('mountain-scene').service 'random', ->

  seed = 1

  reset: -> seed = 1

  next: ->
    x = Math.sin(seed++) * 10000
    x - Math.floor x
