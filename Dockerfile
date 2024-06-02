FROM node:18-alpine

WORKDIR /app

COPY frontend/package.json frontend/package-lock.json ./
RUN npm install

COPY frontend/src ./frontend/src
COPY backend/app.py ./backend/

WORKDIR /app/backend

RUN pip install -r requirements.txt

EXPOSE 5000

CMD ["python", "-u", "/app/backend/app.py"] 

