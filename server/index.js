const PORT = process.env.PORT || 3000
const express = require('express')
const colyseus = require('colyseus')
const { monitor } = require('@colyseus/monitor')
const { createServer } = require('http')
const app = express()
const { StateHandlerRoom } = require('./rooms/stateHandler')

app.use(express.json())

// (optional) attach web monitoring panel
app.use('/colyseus', monitor());

app.use(express.static('./bin'))

const gameServer = new colyseus.Server({
  server: createServer(app),
  express: app,
  pingInterval: 0,
})

// gameServer.define("lobby", colyseus.LobbyRoom).enableRealtimeListing()

gameServer.define("state_handler", StateHandlerRoom).enableRealtimeListing()


gameServer.onShutdown(() =>
  console.log(`game server is going down.`)
)

gameServer.listen(PORT)

console.log(`Server listening on port ${PORT}`)
