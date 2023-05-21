# Use the official Node.js 18 image as the base image
FROM node:18-alpine

# Set the working directory to /app
WORKDIR /app

# Copy the package.json and package-lock.json files to the working directory
COPY package*.json ./

# Install the dependencies
RUN npm install --production

# Install pm2 globally
RUN npm install -g pm2

# Copy the rest of the application code to the working directory
COPY . .

# Expose port 5000 for the application
EXPOSE 5000 

# Start the application using pm2
CMD ["pm2-runtime", "index.js"]

# docker build -t cons-api
# docker run -d -p 5000:5000 cons-api
