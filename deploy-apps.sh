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
