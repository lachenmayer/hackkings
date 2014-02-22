THREE = require './lib/threejs/build/three.js'

module.exports = class Crystals
  constructor: (@xAmount, @yAmount, @size, @spacing) ->
    @material = new THREE.MeshBasicMaterial
      wireframe: true
      color: 0xffffff
    @meshes = ((@createMesh (x - @xAmount / 2), (y - @yAmount / 2) for x in [0...@xAmount]) for y in [0...@yAmount])

  mesh: (x, y) ->
    @meshes[y][x]

  createMesh: (x, y) ->
    mesh = new THREE.Mesh new THREE.OctahedronGeometry(@size), @material
    mesh.position.x = x * @spacing
    mesh.position.z = y * @spacing
    mesh

  addToScene: (scene) ->
    for row in @meshes
      for mesh in row
        scene.add mesh

  bob: (time) ->
    frequency = 2 * Math.PI / 4000
    amplitude = 10
    for y in [0...@yAmount]
      for x in [0...@xAmount]
        offset = x / frequency + Math.sin(y / frequency)
        @mesh(x, y).position.y = amplitude * Math.sin(time * frequency + offset)
