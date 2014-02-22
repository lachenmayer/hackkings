THREE = require './lib/threejs/build/three.js'
THREE.PointerLockControls = require './lib/PointerLockControls.js'
$ = require './lib/jquery/dist/jquery.js'

Crystals = require './crystals'

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

  camera.position.z = 2000
  camera.position.y = 200

  crystals = new Crystals 11, 11, 30, 220
  crystals.addToScene scene

  light = new THREE.PointLight 0xffffff

  light.position.x = 100
  light.position.y = 100
  light.position.z = 100

  scene.add light

  controls = new THREE.PointerLockControls camera
  scene.add controls.getObject()
  controls.enabled = true

  socket = io.connect 'http://localhost'
  socket.on 'brainwavez', (data) ->
    if data.eSense?
      {eSense} = data
      console.log eSense
      crystals.wavelength = eSense.attention * 1000

  tick = 0
  startTime = time = Date.now()
  render = ->
    controls.update Date.now() - time
    crystals.bob time - startTime
    renderer.render scene, camera
    time = Date.now()
    window.requestAnimationFrame render
  window.requestAnimationFrame render

  container.append(renderer.domElement)

