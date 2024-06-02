# Stage 1: Build the React frontend
FROM node:18.20.3-alpine AS build

WORKDIR /app

COPY frontend/package.json ./frontend/
RUN cd frontend && npm install

COPY frontend/src ./frontend/src
COPY frontend/public ./frontend/public
WORKDIR /app/frontend
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
