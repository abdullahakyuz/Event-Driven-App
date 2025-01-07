# Event-Driven-App

Event-Driven-App is a project that implements an event-driven architecture using Kafka, Zookeeper, MongoDB, and Kubernetes. This project consists of microservices that produce and consume events using Kafka.

## Table of Contents
- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Project Structure](#project-structure)
- [Contributing](#contributing)
- [License](#license)

## Features
- Event-driven architecture with Kafka and Zookeeper
- Data storage with MongoDB
- Container orchestration with Kubernetes
- Easy deployment with Helm chart

## Requirements
- Docker
- Kubernetes
- Helm
- Terraform
- Java 17

## Installation

### 1. Clone the Repository
```sh
git clone https://github.com/your-username/Event-Driven-App.git
cd Event-Driven-App
```

### 2. Set Up Kubernetes Cluster
Set up your Kubernetes cluster using Terraform. Navigate to the terraform directory and run the following commands:
```sh
cd terraform
terraform init
terraform apply
```

### 3. Install Helm Chart
Deploy the applications to your Kubernetes cluster using the Helm chart:
```sh
helm install event-driven-app ./event-driven-app
```

### 4. Apply Kubernetes Manifest Files
Deploy the applications using the classic Kubernetes manifest files:
```sh
kubectl apply -f k8s-manifests/
```

## Usage
After deploying the application, you can check the status of the pods using the following command:
```sh
kubectl get pods
```

### Using the API Service
You can query events stored in MongoDB using the API service. For example:
```sh
curl http://<api-service-ip>/events?eventType=test-event
```

## Project Structure
- `k8s-manifests/`: Kubernetes manifest files
- `event-driven-app/`: Helm chart files
- `terraform/`: Terraform files
- `apps/`: Application source code and Docker compose file

## Contributing
If you would like to contribute, please submit a pull request or open an issue.

## License
This project is licensed under the MIT License. See the LICENSE file for more information.