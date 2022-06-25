from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Myke, progess was made...DevOps Rocks!!!'
