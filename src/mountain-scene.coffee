
# depends: mountain

class @MountainScene
  constructor: ->
    @_scene    = new THREE.Scene()
    @_camera   = new THREE.PerspectiveCamera 90, window.innerWidth / window.innerHeight, 0.1, 1000
    @renderer  = new THREE.WebGLRenderer()

    @renderer.setSize window.innerWidth, window.innerHeight

    @_camera.position.z = 10

    @_roughness = 0.8
    @_initialDisplacement = 50

    @_mountain = new Mountain @_roughness, @_initialDisplacement

    @_scene.add @_mountain.object

  render: ->
    @renderer.render @_scene, @_camera
    requestAnimationFrame => @render()

  _update: ->
    @_scene.remove @_mountain.object
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

