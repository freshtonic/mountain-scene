
# depends: mountain

class @MountainScene
  constructor: ->
    @scene    = new THREE.Scene()
    @camera   = new THREE.PerspectiveCamera 90, window.innerWidth / window.innerHeight, 0.1, 1000
    @renderer = new THREE.WebGLRenderer()

    @renderer.setSize window.innerWidth, window.innerHeight

    @camera.position.z = 10

    mountain = Mountain.initial()

    @scene.add mountain.object

  render: ->
    requestAnimationFrame => @render()
    @renderer.render @scene, @camera

