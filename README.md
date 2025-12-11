# Service Registry for Microservices

## Overview
This project implements a cloud-agnostic & language-agnostic **Service Registry (SR)** that allows microservices to register, discover, and manage their availability within a distributed system.  
Each microservice, regardless of the language or cloud platform it is built or deployed on, can communicate with the registry through REST API calls.

The registry itself follows a microservices design, with separate backend and frontend components deployed independently on IBM Code Engine.  
The backend exposes secure REST endpoints for registration, discovery, and health maintenance, while the frontend provides a simple UI to view registered services.

---

## Key Features
- **Language and Cloud Agnostic:** Any service can register or discover others via REST APIs.  
- **Service Lifecycle Management:** Services register at startup, send periodic heartbeats, and deregister on shutdown.  
- **Automatic Cleanup:** Services failing to send a heartbeat within 20 seconds are automatically removed.  
- **Secure Communication:** JWT-based authentication for all API requests.  
- **Containerized Deployment:** Backend and frontend deployed as separate Docker containers on IBM Code Engine.  

### Deployment and Reliability
- **Serverless Deployment (IBM Code Engine):** The Service Registry runs on a serverless, auto-scaling platform with built-in load balancing and request distribution.  
  This ensures the registry can handle varying workloads and prevents a single point of failure.  
- **State Consistency and High Availability (IBM Cloud Database for MySQL):**  
  All registry instances share a central managed database, ensuring consistent service data across all instances.  
  IBM Cloud Database provides high availability, fault tolerance, scalability, and connection management—essential for reliable distributed service coordination.

---

## Tech Stack
- **Backend:** Node.js, Express.js, JWT, IBM Cloud Database for MySQL  
- **Frontend:** React.js  
- **Deployment:** Docker, IBM Code Engine  
- **Database:** IBM Cloud Databases for MySQL

---

## Main API Endpoints
| Method | Endpoint | Description |
|---------|-----------|-------------|
| `POST` | `/register` | Register a new service |
| `POST` | `/reregister` | Send a heartbeat to remain active |
| `DELETE` | `/deregister` | Deregister a service |
| `GET` | `/discover` | Discover active services |