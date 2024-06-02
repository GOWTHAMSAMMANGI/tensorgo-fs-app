# Stage 1: Build the React frontend
FROM node:18-alpine AS build

WORKDIR /app

COPY frontend/package.json frontend/package-lock.json ./
RUN npm install

COPY frontend/src ./frontend/src
RUN npm run build

# Copy requirements.txt to the build context of this stage
COPY backend/requirements.txt ./ 

# Stage 2: Build the Python backend and final image
FROM python:3.9-slim 

WORKDIR /app

# Now copy from the build context of this stage
COPY --from=build /app/backend/requirements.txt ./backend/ 

RUN pip install -r ./backend/requirements.txt 

COPY backend/app.py ./backend/

# Copy the built frontend from the previous stage
COPY --from=build /app/build /app/frontend 

EXPOSE 5000

CMD ["python", "-u", "/app/backend/app.py"]



