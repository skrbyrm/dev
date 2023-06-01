# Use the official node image as a parent image
FROM node:18-alpine

# Set the working directory
WORKDIR /usr/src/app

# Copy the file from your host to your current location
COPY package.json .

# Run the command inside your image filesystem
RUN npm install

# Copy the rest of your app's source code from your host to your image filesystem
COPY . .

# Build the react app
RUN npm run build

# Use nginx as a web server
FROM nginx:alpine

# Copy the build folder to nginx's default folder
COPY --from=0 /usr/src/app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Run nginx
CMD ["nginx", "-g", "daemon off;"]

# docker build -t client-app .
# docker run -d -p 80:80 client-app