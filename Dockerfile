WORKDIR /app
# Copy package.json and package-lock.json
COPY package*.json ./
# Install dependencies
RUN npm install
# Copy the rest of the application files
COPY . .
# Build the application
RUN npm run build
# Expose port 4200
EXPOSE 4200
# Start the application
CMD ["npm", "start"]
