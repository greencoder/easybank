import time

from flask import Flask
from flask import request

app = Flask(__name__)

@app.route("/export/transactions", methods=['GET', 'POST'])
def transactions():
    time.sleep(1)
    return app.send_static_file('transactions.json')

if __name__ == "__main__":
    app.debug = True
    app.run('0.0.0.0')