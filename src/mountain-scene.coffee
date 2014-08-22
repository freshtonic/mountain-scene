
# depends: mountain-scene.module

angular.module('mountain-scene').factory 'MountainScene', (Mountain, random) ->

  class MountainScene
    constructor: ->
      @_seed     = 1
      @_scene    = new THREE.Scene()
      @_camera   = new THREE.PerspectiveCamera 90, window.innerWidth / window.innerHeight, 0.1, 1000
      @renderer  = new THREE.WebGLRenderer()

      @renderer.setSize window.innerWidth, window.innerHeight

      @_camera.position.z = 250

      @_roughness = 0.65
      @_initialDisplacement = 65
      @_leftHeight = 2
      @_rightHeight = 2

      @_mountain = new Mountain {@roughness, @initialDisplacement, @leftHeight, @rightHeight}

      @_scene.add @_mountain.object

    regenerate: ->
      @_seed = Math.random() * 100000
      @_update()

    render: ->
      @renderer.render @_scene, @_camera
      requestAnimationFrame => @render()

    _update: ->
      @_scene.remove @_mountain.object
      random.reset @_seed
      @_mountain = new Mountain {@roughness, @initialDisplacement, @leftHeight, @rightHeight}
      @_scene.add @_mountain.object

    Object.defineProperties @::,

      roughness:
        get: -> @_roughness
        set: (value) ->
          @_roughness = parseFloat value
          @_update()

      initialDisplacement:
        get: -> @_initialDisplacement
        set: (value) ->
          @_initialDisplacement = parseFloat value
          @_update()

      leftHeight:
        get: -> @_leftHeight
        set: (value) ->
          @_leftHeight = parseFloat value
          @_update()

      rightHeight:
        get: -> @_rightHeight
        set: (value) ->
          @_rightHeight = parseFloat value
          @_update()

      cameraZ:
        get: -> @_camera.position.z
        set: (value) ->
          @_camera.position.z = parseFloat value
          @_update()

