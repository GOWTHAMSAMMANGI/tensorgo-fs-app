# Stage 1: Build the React frontend
FROM node:18-alpine AS build-stage

WORKDIR /app

COPY frontend/package.json ./

RUN npm install

COPY frontend/src ./frontend/src
RUN npm run build

# Stage 2: Build the Python backend and final image
FROM python:3.9-slim 

WORKDIR /app

COPY backend/requirements.txt ./backend/
RUN pip install -r ./backend/requirements.txt
COPY backend/app.py ./backend/

# Copy the built frontend from the previous stage
COPY --from=build-stage /app/build /app/frontend 

CMD ["python", "-u", "/app/backend/app.py"]
