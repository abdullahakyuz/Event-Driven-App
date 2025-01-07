# Kubernetes Manifests Documentation

This directory contains Kubernetes manifest files for deploying a microservices architecture that includes Zookeeper, Kafka, MongoDB, a Producer, a Consumer, and an API service. Each service is defined with its respective deployment and service files.

## Services Overview

- **Zookeeper**: Manages the Kafka cluster and provides coordination services.
- **Kafka**: A distributed streaming platform that the Producer and Consumer services interact with.
- **MongoDB**: A NoSQL database used by the Consumer and API services for data storage.
- **Producer**: A service that sends messages to the Kafka topic.
- **Consumer**: A service that reads messages from the Kafka topic.
- **API**: A service that provides an interface for interacting with the Producer and Consumer services.

## Applying the Manifests

To deploy the services to your Kubernetes cluster, follow these steps:

1. Ensure you have access to a Kubernetes cluster and `kubectl` is configured to communicate with it.
2. Navigate to the directory containing the manifests:
   ```
   cd k8s-manifests
   ```
3. Apply the manifests in the following order to ensure dependencies are met:
   ```
   kubectl apply -f zookeeper-deployment.yaml
   kubectl apply -f zookeeper-service.yaml
   kubectl apply -f kafka-deployment.yaml
   kubectl apply -f kafka-service.yaml
   kubectl apply -f mongo-deployment.yaml
   kubectl apply -f mongo-service.yaml
   kubectl apply -f producer-deployment.yaml
   kubectl apply -f producer-service.yaml
   kubectl apply -f consumer-deployment.yaml
   kubectl apply -f consumer-service.yaml
   kubectl apply -f api-deployment.yaml
   kubectl apply -f api-service.yaml
   ```

## Accessing the Services

- The API service can be accessed on port `3000`.
- MongoDB is accessible on port `27017`.
- Kafka can be accessed on port `9092`.
- Zookeeper can be accessed on port `2181`.

Ensure that your Kubernetes cluster allows for external access to these ports if you need to connect from outside the cluster.

## Notes

- Make sure to adjust the replicas and resource limits in the deployment files according to your cluster's capacity and requirements.
- Monitor the logs of each service to troubleshoot any issues during deployment or runtime.

This README provides a high-level overview of the Kubernetes manifests and how to deploy the services. For detailed configurations, refer to the individual manifest files.