FROM mcr.microsoft.com/azure-sql-edge

# Set environment variables for SQL Server instance
ENV MSSQL_SA_PASSWORD=cGFzc3dvcmQ=
ENV ACCEPT_EULA=Y

# Create a database directory
USER root
RUN mkdir -p /var/opt/mssql/data

# Grant permissions to the database directory
RUN chmod -R g=u /var/opt/mssql/data

# Add a volume to persist data
VOLUME /var/opt/mssql/data

# Expose the SQL Server port
EXPOSE 1433

# Start SQL Server
CMD /opt/mssql/bin/sqlservr

# for password convert         echo -n "password" | base64
# docker build -t sqlserver .
# docker run -d -p 1433:1433 -v my_sql_data:/var/opt/mssql/data sqlserver

# docker run -d -p 1433:1433 sql1
# connect to container ? docker exec -it 114eedc2a535 bash
# list sql services ? /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P cGFzc3dvcmQ== -Q "SELECT servicename, process_id, startup_type_desc, status_desc FROM sys.dm_server_services"

#  sudo docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=cGFzc3dvcmQ=" -p 1433:1433 --name sql1 --hostname sql1 -d mcr.microsoft.com/mssql/server:2022-latest


# docker run -e "ACCEPT_EULA=1" -e "MSSQL_SA_PASSWORD=cGFzc3dvcmQ=" -e "MSSQL_PID=Developer" -e "MSSQL_USER=SA" -p 1433:1433 -d --name=sql mcr.microsoft.com/azure-sql-edge
