## Deploy MySQL on cluster

To deploy MySQL an existing Kubernetes cluster, you will need to create the following YAML files:

* pv.yaml (Persistent Volume)
* pvc.yaml (Persistent Volume Claim)
* storageclass.yaml (Storage Class)
* secret.yaml
* mysql.yaml (MySQL deployment and service)
* phpmyadmin.yaml (PHPMyAdmin deployment and service)

Here is an overview of each of these files:

### pv.yaml (Persistent Volume)
A Persistent Volume (PV) is a storage resource that is provisioned by an administrator and can be used by a Kubernetes cluster. It can be thought of as a network-attached hard drive that can be shared across multiple pods. 
The PV.yaml file is used to create a Persistent Volume for your MySQL database.

Here is the pv.yaml file:

***
```
apiVersion: v1
kind: PersistentVolume
metadata:
  name: mysql-pv
spec:
  capacity:
    storage: 5Gi
  accessModes:
    - ReadWriteMany
  hostPath:
    path: /data/mysql-pv
  nodeAffinity:
    required:
      nodeSelectorTerms:
      - matchExpressions:
        - key: kubernetes.io/hostname
          operator: In
          values:
          - instance-1

```
***

This YAML file defines a Persistent Volume named mysql-pv with a storage capacity of 10GB. It uses a Storage Class named local-storage and the access mode is set to ReadWriteMany, 
meaning that only one pod can use the volume at a time. The hostPath is set to /data/mysql-pv, which is the location on the node where the PV will be mounted.

### pvc.yaml (Persistent Volume Claim)

A Persistent Volume Claim (PVC) is a request for storage resources by a pod. It is used to bind a pod to a Persistent Volume. 
The PVC.yaml file is used to create a Persistent Volume Claim for your MySQL database.

Here is the pvc.yaml file:
***
```
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: mysql-pvc
spec:
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 5Gi
```
***

This YAML file defines a Persistent Volume Claim named mysql-pvc with a storage capacity of 10GB. It uses the same Storage Class named local-storage and access mode ReadWriteOnce as the PV. 
The PVC will request the storage resources from the PV and bind the pod to the PV.

### storageclass.yaml (Storage Class)

A Storage Class is used to define the type of storage that is available to your Kubernetes cluster. It defines the provisioner that will be used to provision the storage resources, 
as well as any other parameters that are needed for storage provisioning. The storageclass.yaml file is used to create a Storage Class for your MySQL database.

Here is the storageclass.yaml file:

***
```
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: mysql-storage
provisioner: kubernetes.io/no-provisioner
volumeBindingMode: WaitForFirstConsumer
```
***

This YAML file defines a Storage Class named local-storage. It uses a provisioner named kubernetes.io/no-provisioner, which means that the storage resources will be provisioned by the administrator. 
The volumeBindingMode is set to WaitForFirstConsumer, meaning that the PV will not be bound until a pod requests storage resources.

### Create secret environment

Before creating mysql.yaml create secret for mysql
```
kubectl create secret generic mysql-secrets --from-literal=MYSQL_ROOT_PASSWORD=example --from-literal=MYSQL_DATABASE=example --from-literal=MYSQL_USER=example --from-literal=MYSQL_PASSWORD=example
```

### mysql.yaml (MySQL deployment and service)

The MySQL deployment and service YAML file will create a deployment and service for the MySQL database. 
This will allow multiple replicas of the pod to be created, providing high availability and scalability for your database.

Here is the mysql.yaml file:

***
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mysql-deployment
spec:
  selector:
    matchLabels:
      app: mysql
  replicas: 1
  template:
    metadata:
      labels:
        app: mysql
    spec:
      tolerations:
      - key: "node-role.kubernetes.io/worker"
        operator: "Exists"
        effect: "NoSchedule"
      containers:
        - name: mysql
          image: mysql:8
          envFrom:
          - secretRef:
              name: mysql-secrets
          ports:
            - containerPort: 3306
          volumeMounts:
            - name: mysql-persistent-storage
              mountPath: /var/lib/mysql
      volumes:
        - name: mysql-persistent-storage
          persistentVolumeClaim:
            claimName: mysql-pvc
---
apiVersion: v1
kind: Service
metadata:
  name: mysql-service
spec:
  type: NodePort
  selector:
    app: mysql
  ports:
  - name: mysql
    port: 3306
    targetPort: 3306
    nodePort: 31000
  clusterIP: "10.101.99.126"
```
***


This YAML file defines a Deployment for MySQL with a single replica. It uses the latest version of the MySQL image and sets the `MYSQL_ROOT_PASSWORD` environment variable to `mypassword`. 
The container listens on port 3306 and mounts the `mysql-persistent-storage` volume to `/var/lib/mysql`.
A volume named `mysql-persistent-storage` is also defined in the Deployment, which is linked to the `mysql-pvc` PVC.
A Service is also defined for the MySQL deployment, which exposes the MySQL port 3306 within the cluster.
Also nodePort exposes the MySQL port 31000 for remote connection.

### Connect MySQL remotely and restore database
To remotely connect to a MySQL database using mysql and restore a database from a .sql file:

! Ensure that the remote MySQL server is accessible from your local machine. This may involve allowing ports and configuring firewall rules to enable remote connections.

* Connect to the remote MySQL server using mysql:
```
mysql -u <username> -p <database_name> < <path_to_sql_file>

```

```
mysql -h instance-2 -P 31000 -u root -p cons < backup.sql
```
