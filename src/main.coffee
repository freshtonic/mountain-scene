
# depends: mountain-scene

mountainScene = new MountainScene()

$ =>
  document.body.appendChild mountainScene.renderer.domElement
  mountainScene.render()
