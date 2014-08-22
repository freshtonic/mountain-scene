
# depends: app.module

angular.module('mountain-scene').factory 'Mountain', (random) ->

  buildTree = (roughness) ->
    build = (segment, depth, displacement) ->
      avgY = (segment.l + segment.r) / 2
      change = (random.next() * 2 - 1) * displacement
      y = avgY + change

      displacement = displacement * roughness

      left  = { l: segment.l, r: y         }
      right = { l: y,         r: segment.r }

      segment.children = [left, right]

      if depth > 1
        build left,  depth - 1, displacement
        build right, depth - 1, displacement

      segment

  flattenTree = (segment, heights=[]) ->

    if segment.children?
      flattenTree segment.children[0], heights
      flattenTree segment.children[1], heights

    if not segment.children?
      heights.push segment.l

    heights

  class Mountain

    constructor: (roughness, initialDisplacement) ->
      segment = { l: 1, r: 1}
      tree    = buildTree(roughness) segment, 11, initialDisplacement
      heights = flattenTree tree
      shape = new THREE.Shape()

      x = -512
      shape.moveTo x, heights[0]
      for h in heights[1..]
        x += 1
        shape.lineTo x, h

      shape.lineTo x, -20
      shape.lineTo -512, -20
      shape.lineTo 512, heights[0]

      geometry = new THREE.ShapeGeometry shape
      material = new THREE.MeshBasicMaterial color: 0x00ffff

      @object = new THREE.Mesh(geometry, material)
      @object.position.x = -30


