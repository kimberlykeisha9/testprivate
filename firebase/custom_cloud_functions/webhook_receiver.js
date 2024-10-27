const functions = require("firebase-functions");
const admin = require("firebase-admin");
// To avoid deployment errors, do not call admin.initializeApp() in your code
const express = require("express");
const app = express();

// Middleware to parse JSON payload
app.use(express.json());

app.post("/", (req, res) => {
  const { event, data } = req.body; // Extract the event and data from the payload

  console.log(`Received event: ${event}`);

  // Handle different events
  switch (event) {
    case "room.started":
      handleRoomStarted(data);
      break;
    case "participant.joined":
      handleParticipantJoined(data);
      break;
    case "participant.left":
      handleParticipantLeft(data);
      break;
    case "room.ended":
      handleRoomEnded(data);
      break;
    default:
      console.log("Unhandled event:", event);
  }

  // Acknowledge the webhook
  res.status(200).send("Event processed");
});

// Define handlers for specific events
function handleRoomStarted(data) {
  console.log("Room started:", data.room_id);
  // Add your custom logic here
}

function handleParticipantJoined(data) {
  console.log("Participant joined:", data.peer_id, "in room:", data.room_id);
  // Add your custom logic here
}

function handleParticipantLeft(data) {
  console.log("Participant left:", data.peer_id, "from room:", data.room_id);
  // Add your custom logic here
}

function handleRoomEnded(data) {
  console.log("Room ended:", data.room_id);
  // Add your custom logic here
}

// Cloud Function entry point
exports.webhookReceiver = app;
