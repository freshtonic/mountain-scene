
class MountainScene
  constructor: ->
    @scene    = new THREE.Scene()
    @camera   = new THREE.PerspectiveCamera 90, window.innerWidth / window.innerHeight, 0.1, 1000
    @renderer = new THREE.WebGLRenderer()

    @renderer.setSize window.innerWidth, window.innerHeight

    @camera.position.z = 10

    shape = new THREE.Shape()
    shape.moveTo 0, 0
    shape.lineTo 0, 1
    shape.lineTo 1, 1
    shape.lineTo 0, 0

    geometry = new THREE.ShapeGeometry shape

    material  = new THREE.MeshBasicMaterial color: 0x00ffff
    mesh      = new THREE.Mesh( geometry, material )

    @scene.add mesh

    $ =>
      document.body.appendChild @renderer.domElement
      @render()

  render: ->
    requestAnimationFrame => @render()
    @renderer.render @scene, @camera

new MountainScene()

