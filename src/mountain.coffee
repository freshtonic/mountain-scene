
# depends: mountain-scene.module

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

  lowest = (heights) ->
    heights.reduce (l, h) ->
      l = h if h < l
      l
    , 0

  normalize = (heights) ->
    l = lowest heights
    heights.map (h) -> h - l + 1

  class Mountain

    constructor: ({roughness, initialDisplacement, leftHeight, rightHeight, zPos, color} = params) ->
      segment = { l: leftHeight or 1, r: rightHeight or 1 }
      color= 0xBBBBBB if not color?
      tree    = buildTree(roughness) segment, 10, initialDisplacement
      heights = flattenTree tree
      shape = new THREE.Shape()

      heights = normalize heights

      x = -(heights.length / 2)
      shape.moveTo x, 0
      shape.lineTo x, heights[0]
      for h in heights[1..]
        x += 1
        shape.lineTo x, h

      shape.lineTo x, 0
      shape.lineTo -(heights.length / 2), 0

      geometry = new THREE.ShapeGeometry shape
      material = new THREE.MeshBasicMaterial color: color

      @object = new THREE.Mesh(geometry, material)
      @object.position.z = zPos or 0


