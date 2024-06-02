# Stage 1: Build the React frontend
FROM node:18.20.3-alpine AS build

WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY frontend/package.json frontend/package-lock.json ./frontend/

# Clear npm cache and install dependencies
RUN cd frontend && npm cache clean --force && npm ci

# Copy the rest of the frontend source code
COPY frontend/src ./frontend/src
COPY frontend/public ./frontend/public

WORKDIR /app/frontend

# Set environment variable to fix OpenSSL issue
ENV NODE_OPTIONS=--openssl-legacy-provider

RUN npm run build

# Stage 2: Build the Python backend and final image
FROM python:3.9.19-alpine

WORKDIR /app

# Copy requirements.txt to the current stage
COPY backend/requirements.txt ./backend/

RUN pip install -r ./backend/requirements.txt

COPY backend/app.py ./backend/

# Copy the built frontend from the previous stage
COPY --from=build /app/frontend/build /app/frontend/build

EXPOSE 5000

CMD ["python", "-u", "/app/backend/app.py"]
