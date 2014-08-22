
# depends: app.module
# depends: mountain-scene

angular.module('mountain-scene')

  .run ($rootScope) ->

    $rootScope.scene = new MountainScene()

    $ ->
      document.body.appendChild $rootScope.scene.renderer.domElement
      $rootScope.scene.render()
