const express = require('express')
const gameLoop = require('./utilsGameLoop.js')
const webSockets = require('./utilsWebSockets.js')
const debug = true

/*
    WebSockets server, example of messages:

    From client to server:
        - Client init           { "type": "init", "name": "name" }
        - Player movement       { "type": "move", "x": 0, "y": 0 }
        - Player loose          { "type": "loose", "puntuation": 0, "positionList": 0}

    From server to client:
        - Welcome message       { "type": "welcome", "value": "Welcome to the server", "id": 'ABC123', "list": [] }
        - If Server is full     { "type": "error", "value": "Server is full"}
        - Connected list        { "type": "waitingList", "value":"Waiting players", "data": [{"id": 'ABC123', "name": 'Abcd', "x": 0, "y": 0 }, {"id": 'XYZ789', "name": 'Wxyz', "x": 0, "y": 0 }] }
        
    From server to everybody (broadcast):
        - All clients data      { "type": "data", "data": [{"id": 'ABC123', "name": 'Abcd', "x": 0, "y": 0 }, {"id": 'XYZ789', "name": 'Wxyz', "x": 0, "y": 0 }] }
        - Someone connects      { "type": "newClient", id: 'ABC123', "name": "Abcd" }
        - Start game            { "type": "start", "data": ""}
        - Someone loose         { "type": "lost", "positionList": 0 }
        - All clients lost      { "type": "finnish", "data":"[{ "name": 'Abcd', "puntuation": 0 }, { "name": 'Wxyz', "puntuation": 0 }]"}
        - Pipe group            { "type": "pipe", "spacing": 0.3, "centerY": 0.1}
*/

///////////////////
//   VARIABLES   //
///////////////////

var gameStarted = false;
var startMessageSended = false;
var playerLost = [];
var pipeTimer = 0;
var untilFirstPipe = 0;

var ws = new webSockets()
var gLoop = new gameLoop()

// Start HTTP server
const app = express()
const port = process.env.PORT || 8888

// Publish static files from 'public' folder
app.use(express.static('public'))

// Activate HTTP server
const httpServer = app.listen(port, appListen)
async function appListen() {
  console.log(`Listening for HTTP queries on: http://localhost:${port}`)
}

// Close connections when process is killed
process.on('SIGTERM', shutDown);
process.on('SIGINT', shutDown);
function shutDown() {
  console.log('Received kill signal, shutting down gracefully');
  httpServer.close()
  ws.end()
  gLoop.stop()
  process.exit(0);
}

// WebSockets
ws.init(httpServer, port)

ws.onConnection = (socket, id) => {
  if (debug) console.log("WebSocket client connected: " + id)

  if (!gameStarted) {
    // Saludem personalment al nou client
    socket.send(JSON.stringify({
      type: "welcome",
      value: "Welcome to the server",
      id: id
    }))

    // Enviem el nou client a tothom
    ws.broadcast(JSON.stringify({
      type: "newClient",
      id: id
    }))
  } else {
    socket.send(JSON.stringify({
      type: "error",
      value: "Server is full"
    }))
  }
}

ws.onMessage = (socket, id, msg) => {
  if (debug) console.log(`New message from ${id}:  ${msg.substring(0, 32)}...`)

  let clientData = ws.getClientData(id)
  if (clientData == null) return

  let obj = JSON.parse(msg)
  switch (obj.type) {
    case "init":
      clientData.name = obj.name
      let allClientsData = ws.getClientsData()
      if (allClientsData != null) {
        ws.broadcast(JSON.stringify({
          type: "waitingList",
          value: "Waiting players",
          data: allClientsData
        }))

        
        if (allClientsData.length === 4) {
          gameStarted = true;
          console.log('game started');
          if (!startMessageSended) {
            ws.broadcast(JSON.stringify({ type: "start", data: "" }))
          }
          startMessageSended = true;
        }
      }
      break;
    case "move":
      clientData.x = obj.x
      clientData.y = obj.y
      break
    case "loose":
      clientData.puntuation = obj.puntuation
      var posList = obj.positionList
      ws.broadcast(JSON.stringify({
        type: "lost", 
        positionList: posList
      }))
      playerLost.push(JSON.stringify({ name: clientData.name, puntuation: clientData.puntuation }))
  }
}

ws.onClose = (socket, id) => {
  if (debug) console.log("WebSocket client disconnected: " + id)

  // Informem a tothom que el client s'ha desconnectat
  ws.broadcast(JSON.stringify({
    type: "disconnected",
    from: "server",
    id: id
  }))
}

gLoop.init();
gLoop.run = (fps) => {
  // Aquest mètode s'intenta executar 30 cops per segon

  let clientsData = ws.getClientsData()
  
  // Mandem una pipe cada x segons
  if (gameStarted) {
    pipeTimer += 1/fps;
    untilFirstPipe += 1/fps;

    if (pipeTimer >= 2.25 && untilFirstPipe >= 3.25) {
      const rSpacing =  130 + Math.random() * (500 / 4);
      const centerY = rSpacing + Math.random() * (500 - rSpacing);
      ws.broadcast(JSON.stringify({type: "pipe", spacing: rSpacing, centerY: centerY}));
      pipeTimer = 0;
    } else if (untilFirstPipe < 3.25) {
      pipeTimer = 0;
    }
  }

  // Gestionar aquí la partida, estats i final
  if (clientsData.length === 0 && startMessageSended) {
    gameStarted = false;
    startMessageSended = false;
    pipeTimer = 0;
    untilFirstPipe = 0;
    console.log('game ended');
  }

  if (gameStarted && startMessageSended) {
    console.log(clientsData)
    ws.broadcast(JSON.stringify({ type: "data", data: clientsData }))
  } 

  if (playerLost.length === 4) {
    gameLoop = false;
    gameStarted = false;
    startMessageSended = false;
    console.log('game ended');
    ws.broadcast(JSON.stringify({ type: "finnish", data: playerLost }))
    pipeTimer = 0;
    untilFirstPipe = 0;
    playerLost = []
  }

}