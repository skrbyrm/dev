
# Provisioning Virtual Machines on Google Cloud with Terraform and Automating the Deployment of Containerized Applications using Bash Script













# Restore MySQL Database
cd /home/ubuntu/dev/data
apt install mysql-client-core-8.0 -y
mysql -h $selected_node -u root -p cons < cons.sql

# Restore PostgreSQL Database
cd /home/ubuntu/dev/data
apt install postgresql-client-common postgresql-client -y
psql -h $selected_node -p 5432 -U pgadmin -d cons -c "\i postgres.sql"

# Restore SQL Server Database
# for now use SQL Server Management Studio !