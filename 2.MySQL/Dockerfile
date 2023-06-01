FROM mysql:8.0.32

# Expose port 3306
EXPOSE 3306

# Add a volume mount for data persistence
VOLUME /var/lib/mysql

# Start MySQL service
CMD ["mysqld"]


# docker build -t mysql-image .
# docker run --env-file .env -d -p 3306:3306 --name mysql-container mysql-image
