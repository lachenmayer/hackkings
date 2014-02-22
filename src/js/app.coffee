THREE = require './lib/threejs/build/three.js'
$ = require './lib/jquery/dist/jquery.js'

screenSize = [window.innerWidth, window.innerHeight]

viewAngle = 45
aspect = screenSize[0] / screenSize[1]
near = 0.1
far = 10000

$ ->
  container = $ '.container'

  renderer = new THREE.WebGLRenderer()
  camera = new THREE.PerspectiveCamera viewAngle, aspect, near, far
  renderer.setSize(screenSize...)

  scene = new THREE.Scene()
  scene.add camera

  camera.position.z = 300

  material = new THREE.MeshLambertMaterial
    color: 0xcc0000
  sphere = new THREE.Mesh new THREE.SphereGeometry(50, 16, 16), material

  scene.add sphere

  light = new THREE.PointLight 0xffffff

  light.position.x = 100
  light.position.y = 100
  light.position.z = 100

  scene.add light

  renderer.render scene, camera

  container.append(renderer.domElement)