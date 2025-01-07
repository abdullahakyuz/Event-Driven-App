const express = require('express');
const { MongoClient } = require('mongodb');

const app = express();
const uri = process.env.MONGO_URI || 'mongodb://localhost:27017';
const mongoClient = new MongoClient(uri, { useNewUrlParser: true, useUnifiedTopology: true });

async function connectToMongo() {
  try {
    await mongoClient.connect();
    console.log("Connected to MongoDB");
  } catch (err) {
    console.error(err);
  }
}

connectToMongo();

app.get('/events', async (req, res) => {
  const { eventType, startTime, endTime } = req.query;
  const db = mongoClient.db('events');
  const collection = db.collection('eventLogs');

  const query = {};
  if (eventType) query.eventType = eventType;
  if (startTime || endTime) {
    query.timestamp = {};
    if (startTime) query.timestamp.$gte = new Date(startTime);
    if (endTime) query.timestamp.$lte = new Date(endTime);
  }

  try {
    const events = await collection.find(query).toArray();
    res.json(events);
  } catch (err) {
    res.status(500).send(err.message);
  }
});

const port = process.env.PORT || 3000;
app.listen(port, () => {
  console.log(`API server listening on port ${port}`);
});