from flask import Flask
import os

app = Flask(__name__)


@app.route("/")
def hi():
    return f"Hi from {os.environ.get('HI_VALUE', 'stranger')}\n"


if __name__ == '__main__':
    port = int(os.environ.get("HI_PORT", 5000))
    app.run(debug=True, host='0.0.0.0', port=port)
