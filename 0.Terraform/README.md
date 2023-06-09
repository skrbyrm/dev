
# Provisioning Virtual Machines on Google Cloud with Terraform and Automating the Deployment of Containerized Applications using Bash Script
This repository provides scripts and instructions for provisioning virtual machines on Google Cloud Platform using Terraform and automating the deployment of containerized applications using a Bash script.

## Add firewall rule
```
cd add_firewall
terraform init
terraform apply
```

## Up instances
```
cd up-instances
terraform init
terraform apply
```

## Deploy all app's in dev folder 
```
./deploy-apps.sh
```

#### Restore MySQL Database
```
cd /home/ubuntu/dev/data
apt install mysql-client-core-8.0 -y
mysql -h $selected_node -u root -p cons < cons.sql
```
#### Restore PostgreSQL Database
```
cd /home/ubuntu/dev/data
apt install postgresql-client-common postgresql-client -y
psql -h $selected_node -p 5432 -U pgadmin -d cons -c "\i postgres.sql"
```
#### Restore SQL Server Database
 ! for now use SQL Server Management Studio !
