const WebSocket = require("ws");

// start the server and specify the port number
const port = 8080;
const wss = new WebSocket.Server({ port: port });
console.log(`[WebSocket] Starting WebSocket server on localhost:${port}`);

wss.on("connection", (ws, request) => {
  const clientIp = ws._socket.remoteAddress;

  console.log(`[WebSocket] Client with IP ${clientIp} has connected`);
  ws.send("Thanks for connecting to this nodejs websocket server");

  ws.on("message", (message) => {
    if (message.toString() != "send_something") return;

    wss.clients.forEach((client) => {
      if (client.readyState === WebSocket.OPEN) {
        setInterval(() => {
          const strangeMessage = Date.now().toString();

          client.send(strangeMessage);
        }, 4000);
      }
    });

    console.log(`[WebSocket] Message ${message} was received`);
  });
});
