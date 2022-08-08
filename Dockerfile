
#Dockerfile of ShoppingList - backend
#Use official node image as the base image
FROM node:16-alpine as build

# Set the working directory
WORKDIR /usr/local/server

# Copy typescript config
COPY tsconfig.json .

# Copy npm package files
COPY package*.json ./

# Install all the dependencies
RUN npm install

# Add the source code to app
COPY src/ src/

# Compile typescript files
RUN npm run build


FROM node:16-alpine

# Set the working directory
WORKDIR /usr/local/server

# Copy npm package files
COPY package*.json ./

#Install prod dependencies
RUN npm install --omit=dev

#Copy build output
COPY --from=build /usr/local/server/dist/ /usr/local/server/

EXPOSE 8080

# Generate the build of the application
CMD ["npm", "run", "start"]