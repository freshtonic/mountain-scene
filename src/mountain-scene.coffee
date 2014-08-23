
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

      @_roughness                       = 0.65
      @_initialDisplacement             = 65
      @_roughnessChangeFactor           = 0.98
      @_initialDisplacementChangeFactor = 0.95
      @_leftHeight                      = 2
      @_rightHeight                     = 2

      @_makeMountains()

      for mountain in @_mountains
        @_scene.add mountain.object

    regenerate: ->
      @_seed = Math.random() * 100000
      @_update()

    render: ->
      @renderer.render @_scene, @_camera
      requestAnimationFrame => @render()

    _makeMountains: ->
      @_mountains = []
      zPos = 0
      color = 0x444444
      [roughness, initialDisplacement, leftHeight, rightHeight] =
        [@roughness, @initialDisplacement, @leftHeight, @rightHeight]
      for n in [0...4]
        random.reset @_seed
        @_mountains.push new Mountain {roughness, initialDisplacement, leftHeight, rightHeight, zPos, color}
        roughness *=  @_roughnessChangeFactor
        initialDisplacement *= @_initialDisplacementChangeFactor
        zPos += 20
        color *= 0.08

    _update: ->
      for mountain in @_mountains
        @_scene.remove mountain.object
      random.reset @_seed
      @_makeMountains()
      for mountain in @_mountains
        @_scene.add mountain.object

    Object.defineProperties @::,

      roughness:
        get: -> @_roughness
        set: (value) ->
          @_roughness = parseFloat value
          @_update()

      roughnessChangeFactor:
        get: -> @_roughnessChangeFactor
        set: (value) ->
          @_roughnessChangeFactor = parseFloat value
          @_update()

      initialDisplacement:
        get: -> @_initialDisplacement
        set: (value) ->
          @_initialDisplacement = parseFloat value
          @_update()

      initialDisplacementChangeFactor:
        get: -> @_initialDisplacementChangeFactor
        set: (value) ->
          @_initialDisplacementChangeFactor = parseFloat value
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

      cameraX:
        get: -> @_camera.position.x
        set: (value) ->
          @_camera.position.x = parseFloat value

      cameraY:
        get: -> @_camera.position.y
        set: (value) ->
          @_camera.position.y = parseFloat value

      cameraZ:
        get: -> @_camera.position.z
        set: (value) ->
          @_camera.position.z = parseFloat value

