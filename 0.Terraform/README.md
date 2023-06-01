
# Provisioning Virtual Machines on Google Cloud with Terraform and Automating the Deployment of Containerized Applications using Bash Script

This study automates opening the desired number of virtual machines in Google Cloud by running the relevant terraform and Bash scripts in only 3 steps, adding firewall rules for port settings and up all related applications with a linux script.

Manual installation of the relevant application in each folder and installation on Kubernetes Cluster have also been practiced.


## 1. Add firewall rule

This terraform script creating firewall rule for opening desired ports to outside world.
```
cd 0.Terraform/add_firewall
```

```
terraform init
```
```
terraform apply
```

## 2. Up instances

This terraform script creating instances and saving the instances name and their ip's on `/etc/hosts`. 
```
cd 0.Terraform/up-instances
```

```
terraform init
```

```
terraform apply
```

## 3. Deploy all app's in dev folder 

* Run deploy-apps.sh and enter node ip's which you created with terraform. You can find node-ip and node names from `/etc/hosts` file.
```
./deploy-apps.sh
```

```
#!/bin/bash

# Prompt for node selection
read -p "Enter a node IP : " selected_node

# Replace "instance-ip" with "selected_node-ip" in the file
sed -i "s/instance-ip/$selected_node/g" /home/ubuntu/dev/8.Web_API-Node.js-Ngnix-React-UI/client/.env
sed -i "s/instance-ip/$selected_node/g" /home/ubuntu/dev/8.Web_API-Node.js-Ngnix-React-UI/server/.env

# Transfer folder to selected node using scp
echo "Transferring folder to $selected_node..."
scp -r /home/ubuntu/dev root@$selected_node:/home/ubuntu

# Replace "$selected_node" with "instance-ip" in the file
sed -i "s/$selected_node/instance-ip/g" /home/ubuntu/dev/8.Web_API-Node.js-Ngnix-React-UI/client/.env
sed -i "s/$selected_node/instance-ip/g" /home/ubuntu/dev/8.Web_API-Node.js-Ngnix-React-UI/server/.env

# Connect to selected node via ssh and run Dockerfile
echo "Connecting to $selected_node..."
ssh root@$selected_node <<EOF
apt-get update | apt-get upgrade -y

# MySQL 
cd /home/ubuntu/dev/2.MySQL
docker build -t mysql-image .
docker run --env-file .env -d -p 3306:3306 --name mysql-container mysql-image

# PhpMyadmin
cd /home/ubuntu/dev/3.PhpMyAdmin
docker build -t my-phpmyadmin .
docker run --env-file .env -d -p 3000:80 --name phpmyadmin-container my-phpmyadmin

# PostgreSQL & Adminer
cd /home/ubuntu/dev/4.PostgreSQL
docker-compose up -d

# SQL Server
cd /home/ubuntu/dev/6.SQL-Server
docker build -t sql-edge .
docker run -d -p 1433:1433 -v my_sql_data:/var/lib/mssql/data sql-edge

# Web_API-Node.js-Ngnix-React-UI

cd /home/ubuntu/dev/8.Web_API-Node.js-Ngnix-React-UI/server
docker build -t node-api .
docker run -d -p 5000:5000 node-api

cd /home/ubuntu/dev/8.Web_API-Node.js-Ngnix-React-UI/client
docker build -t client-app .
docker run -d -p 80:80 client-app
EOF
```

* After process finished check result 
```
root@instance-1:/home/ubuntu/dev# docker ps -a
CONTAINER ID   IMAGE           COMMAND                  CREATED       STATUS       PORTS                                                  NAMES
35b3950bd8d8   client-app      "/docker-entrypoint.…"   5 hours ago   Up 5 hours   0.0.0.0:80->80/tcp, :::80->80/tcp                      relaxed_wozniak
3819adc47e3b   node-api        "docker-entrypoint.s…"   5 hours ago   Up 5 hours   0.0.0.0:5000->5000/tcp, :::5000->5000/tcp              intelligent_grothendieck
72e31d02a70b   my-phpmyadmin   "/docker-entrypoint.…"   7 hours ago   Up 7 hours   0.0.0.0:3000->80/tcp, :::3000->80/tcp                  phpmyadmin-container
b672ef0e0d5f   sql-edge        "/opt/mssql/bin/perm…"   7 hours ago   Up 7 hours   1401/tcp, 0.0.0.0:1433->1433/tcp, :::1433->1433/tcp    mystifying_galileo
e47a6378fcc1   adminer         "entrypoint.sh php -…"   8 hours ago   Up 8 hours   0.0.0.0:8080->8080/tcp, :::8080->8080/tcp              4postgresql_adminer_1
e3705d643d7b   postgres        "docker-entrypoint.s…"   8 hours ago   Up 8 hours   0.0.0.0:5432->5432/tcp, :::5432->5432/tcp              4postgresql_db_1
b33c9d5592cf   mysql-image     "docker-entrypoint.s…"   9 hours ago   Up 9 hours   0.0.0.0:3306->3306/tcp, :::3306->3306/tcp, 33060/tcp   mysql-container
```

### Restore MySQL Database
```
cd /home/ubuntu/dev/data
```
```
apt install mysql-client-core-8.0 -y
```
```
mysql -h $selected_node -u root -p cons < cons.sql
```
### Restore PostgreSQL Database
```
cd /home/ubuntu/dev/data
```
```
apt install postgresql-client-common postgresql-client -y
```
```
psql -h $selected_node -p 5432 -U pgadmin -d cons -c "\i postgres.sql"
```
### Restore SQL Server Database

Copy backup file into Sql Server container 
```
docker cp cons.bak b672ef0e0d5f:/home/
```

Connect to Sql Server with `sqlcmd` on Windows
```
sqlcmd -S server_name -U username -P password
```

Restore database with T-SQL 
```
RESTORE DATABASE cons FROM DISK = '/home/cons.bak'
WITH REPLACE, RECOVERY;
GO
```

