# Web App and Web API Deployment on Kubernetes

This repository contains the deployment configuration for a web application and a web API using Docker and Kubernetes.

## Prerequisites

Before proceeding with the deployment, make sure you have the following:

- Docker installed on your local machine
- Kubernetes cluster up and running
- `kubectl` command-line tool configured to connect to your Kubernetes cluster

## Deployment Steps

1. Log in to your Docker registry:

   ```
   docker login
   ```
2. Build the web application Docker image:

```
cd client
docker build -t web-app .
```

3. Build the web API Docker image:

```
cd ../server
docker build -t web-api .
```

4. Tag the Docker images with your registry URL:

```
docker tag web-app:latest brotha/web-app:latest
docker tag web-api:latest brotha/web-api:latest
```

5. Push the Docker images to your registry:

```
docker push brotha/web-app:latest
docker push brotha/web-api:latest
```

6. Apply the Kubernetes deployment and service manifests:

```
kubectl apply -f cons.yaml
```

The deployment includes two components: `react-app` and `web-api`. The `react-app` deployment and service are exposed on port 80, 
while the `web-api` deployment and service are exposed on port 5000.

After applying the manifests, you can access the web application and web API using the `NodePort` assigned to each service.

`Web API: http://instance-2:31600/`
`Web application: http://instance-2:31700/`
