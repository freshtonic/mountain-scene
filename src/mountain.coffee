
initialDisplacement = 50
roughness = 0.8

buildTree = (segment, depth, displacement=initialDisplacement) ->
  avgY = (segment.l + segment.r) / 2
  change = (Math.random() * 2 - 1) * displacement
  y = avgY + change

  displacement = displacement * roughness

  left  = { l: segment.l, r: y         }
  right = { l: y,         r: segment.r }

  segment.children = [left, right]

  if depth > 1
    buildTree left,  depth - 1, displacement
    buildTree right, depth - 1, displacement

  segment

flattenTree = (segment, heights=[]) ->

  if segment.children?
    flattenTree segment.children[0], heights
    flattenTree segment.children[1], heights

  if not segment.children?
    heights.push segment.l

  heights

scaleHeight = (h) ->
  h / 100

class @Mountain

  @initial: ->
    segment = { l: 50, r: 50}
    tree    = buildTree segment, 11
    heights = flattenTree tree
    new Mountain heights

  constructor: (heights) ->
    shape = new THREE.Shape()

    x = 0
    shape.moveTo x, scaleHeight heights[0]
    for h in heights[1..]
      x += 0.5
      shape.lineTo x, scaleHeight h

    shape.lineTo x, scaleHeight -20
    shape.lineTo 0, scaleHeight -20
    shape.lineTo 0, scaleHeight heights[0]

    geometry = new THREE.ShapeGeometry shape
    material = new THREE.MeshBasicMaterial color: 0x00ffff
    @object  = new THREE.Mesh( geometry, material )
    @object.position.x = -30



