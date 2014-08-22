
# depends: mountain-scene
# depends: mountain

mountainScene = new MountainScene()

$ =>
  document.body.appendChild mountainScene.renderer.domElement
  mountainScene.render()
