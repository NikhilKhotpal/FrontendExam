const WebSocket = require('ws');
const wss = new WebSocket.Server({ port: 3000 });

const clients = new Map(); // To store clients and their connections

wss.on('connection', (ws) => {
    console.log('Client connected');
    
    ws.on('message', (message) => {
        const { type, userId, data } = JSON.parse(message);

        if (type === 'REGISTER') {
            clients.set(userId, ws);
        } else if (type === 'OFFER' || type === 'ANSWER' || type === 'ICE_CANDIDATE') {
            const client = clients.get(userId);
            if (client) {
                client.send(message);
            }
        }
    });

    ws.on('close', () => {
        console.log('Client disconnected');
    });
});
