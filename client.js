// client.js
const ws = new WebSocket('ws://localhost:8080');

ws.onopen = () => {
    console.log('WebSocket connection established.');
};

ws.onmessage = (event) => {
    console.log('Received message:', event.data);
};

ws.onerror = (error) => {
    console.error('WebSocket error:', error);
};
