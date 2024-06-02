from flask import Flask, jsonify, request
from flask_cors import CORS

app = Flask(__name__)
CORS(app) # Enable CORS for cross-origin requests from the frontend

greetings = []

@app.route('/api/greetings', methods=['GET'])
def get_greetings():
    return jsonify(greetings)

@app.route('/api/greetings', methods=['POST'])
def add_greeting():
    new_greeting = request.get_json()
    greetings.append(new_greeting)
    return jsonify(new_greeting), 201

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000) 