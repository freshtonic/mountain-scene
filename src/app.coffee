
# depends: app.module

angular.module('mountain-scene')

  .run ($rootScope, MountainScene) ->

    $rootScope.scene = new MountainScene()

    $ ->
      document.body.appendChild $rootScope.scene.renderer.domElement
      $rootScope.scene.render()
