io = require 'socket.io'
express = require 'express'
app = express()
server = require('http').createServer app
path = require 'path'
neurosky = require 'node-neurosky'

io = io.listen server

client = neurosky.createClient
  appName: 'hackkings'
  appKey: '2b00042f7481c7b056c4b410d28f33cf12345678'
client.connect()

io.sockets.on 'connection', (socket) ->
  client.on 'data', (data) ->
    console.log data
    socket.emit 'brainwavez', data


app.use express.static path.resolve('./bin')
server.listen(1337)
console.log 'listening on 1337'