
# depends: mountain-scene.module

angular.module('mountain-scene').factory 'MountainScene', (Mountain, random) ->

  class MountainScene
    constructor: ->
      @_scene    = new THREE.Scene()
      @_camera   = new THREE.PerspectiveCamera 90, window.innerWidth / window.innerHeight, 0.1, 1000
      @renderer  = new THREE.WebGLRenderer()

      @renderer.setSize window.innerWidth, window.innerHeight

      @_camera.position.z = 250

      @_roughness = 0.65
      @_initialDisplacement = 65

      @_mountain = new Mountain @_roughness, @_initialDisplacement

      @_scene.add @_mountain.object

    regenerate: ->
      @_update Math.random() * 100000

    render: ->
      @renderer.render @_scene, @_camera
      requestAnimationFrame => @render()

    _update: (seed) ->
      @_scene.remove @_mountain.object
      random.reset seed
      @_mountain = new Mountain @_roughness, @_initialDisplacement
      @_scene.add @_mountain.object

    Object.defineProperties @::,

      roughness:
        get: -> @_roughness
        set: (value) ->
          @_roughness = value
          @_update()

      initialDisplacement:
        get: -> @_initialDisplacement
        set: (value) ->
          @_initialDisplacement = value
          @_update()

      cameraZ:
        get: -> @_camera.position.z
        set: (value) ->
          @_camera.position.z = value
          @_update()

