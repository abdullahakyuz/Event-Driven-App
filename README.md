# Project Kubernetes Manifests

This repository contains Kubernetes manifest files for deploying a Kafka, Zookeeper, MongoDB, Producer, Consumer, and API services.
## Project Structure

```
project
├── api-deployment.yaml
├── api-service.yaml
├── consumer-deployment.yaml
├── consumer-service.yaml
├── kafka-deployment.yaml
├── kafka-service.yaml
├── mongo-deployment.yaml
├── mongo-service.yaml
├── producer-deployment.yaml
├── producer-service.yaml
├── zookeeper-deployment.yaml
├── zookeeper-service.yaml
└── README.md
```

## Manifest Files

### Zookeeper
- **Deployment:** `zookeeper-deployment.yaml`
- **Service:** `zookeeper-service.yaml`

### Kafka
- **Deployment:** `kafka-deployment.yaml`
- **Service:** `kafka-service.yaml`

### MongoDB
- **Deployment:** `mongo-deployment.yaml`
- **Service:** `mongo-service.yaml`

### Producer
- **Deployment:** `producer-deployment.yaml`
- **Service:** `producer-service.yaml`

### Consumer
- **Deployment:** `consumer-deployment.yaml`
- **Service:** `consumer-service.yaml`

### API
- **Deployment:** `api-deployment.yaml`
- **Service:** `api-service.yaml`

## Notes
- Ensure that your Kubernetes cluster is up and running.
- Modify the manifest files as needed to fit your environment.

## License
This project is licensed under the MIT License.
