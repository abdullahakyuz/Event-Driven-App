const { Kafka } = require('kafkajs');

const kafka = new Kafka({
  clientId: 'producer-app',
  brokers: [process.env.KAFKA_BROKER]
});

const producer = kafka.producer();

const produceMessage = async () => {
  const payload = {
    eventType: 'test-event',
    timestamp: new Date().toISOString(),
    data: { message: 'Hello Kafka' }
  };

  await producer.send({
    topic: 'events',
    messages: [{ value: JSON.stringify(payload) }]
  });

  console.log('Message produced:', JSON.stringify(payload));
};

const run = async () => {
  await producer.connect();
  setInterval(produceMessage, 3000);
};

run().catch(console.error);