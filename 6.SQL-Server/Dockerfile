FROM mcr.microsoft.com/azure-sql-edge

# Set environment variables for SQL Server instance
ENV MSSQL_SA_PASSWORD=bXNzcWw4NzEu
ENV ACCEPT_EULA=Y

# Create a database directory
USER root
RUN mkdir -p /var/lib/mssql/data

# Grant permissions to the database directory
RUN chmod -R g=u /var/lib/mssql/data

# Add a volume to persist data
VOLUME /var/lib/mssql/data

# Expose the SQL Server port
EXPOSE 1433

# Start SQL Server
CMD /opt/mssql/bin/sqlservr

# for password convert         echo -n "password" | base64
# echo 'bXNzcWw4NzEu' | base64 --decode

# docker build -t sql-edge .
# docker run -d -p 1433:1433 -v my_sql_data:/var/lib/mssql/data sql-edge

# connect to container ? docker exec -it 114eedc2a535 bash
# list sql services ? /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P -Q "SELECT servicename, process_id, startup_type_desc, status_desc FROM sys.dm_server_services"
