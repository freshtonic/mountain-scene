
# depends: mountain-scene.module

angular.module('mountain-scene')

  .run ($rootScope, MountainScene) ->

    $rootScope.scene = new MountainScene()

    $rootScope.activeTab = 'Mountains'

    $ ->
      document.body.appendChild $rootScope.scene.renderer.domElement
      $rootScope.scene.render()
