# Use an argument for the node version
ARG NODE_VERSION=20.15.1

# Base image
FROM node:${NODE_VERSION}-alpine

# Use production node environment by default
ENV NODE_ENV=production

# Set the working directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm ci --omit=dev

# Copy the rest of the application files
COPY . .

# Set permissions for the working directory
RUN chown -R node:node /usr/src/app

# Switch to the non-root user
USER node

# Expose the port the application runs on
EXPOSE 3000

# Start the application
CMD ["node", "index.js"]
