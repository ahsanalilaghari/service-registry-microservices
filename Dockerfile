# Step 1: Build the React frontend
FROM node:22 AS frontend-build
WORKDIR /app/front-end
COPY front-end/package.json front-end/package-lock.json ./
RUN npm install
COPY front-end ./
RUN npm run build

# Step 2: Build the Node.js backend
FROM node:22
WORKDIR /app
COPY back-end/package.json back-end/package-lock.json ./back-end/
RUN npm install --prefix ./back-end
COPY back-end ./back-end/
COPY back-end/IBMSQL_Cert_CA.crt /app/back-end/IBMSQL_Cert_CA.crt
COPY --from=frontend-build /app/front-end/.next ./back-end/.next
COPY --from=frontend-build /app/front-end/public ./back-end/public

# Expose the port your app runs on
EXPOSE 4471

# Start the backend server
CMD ["node", "./back-end/server.js"]
