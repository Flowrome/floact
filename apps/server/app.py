from os import environ
from posixpath import abspath
from flask import Flask, Blueprint
from flask_cors import CORS
from dotenv import load_dotenv
from apis.home import home_api

env = environ.get("ENV")

apix_path = environ.get("APIX_PATH", ".")

load_dotenv(dotenv_path=abspath(f"{apix_path}/envs/.env.{env}"))

app = Flask(__name__)
cors = CORS(app)
app.config["CORS_HEADERS"] = "Content-Type"
app.config["DEBUG"] = True

api = Blueprint("api", __name__)


@api.route("/", methods=["GET"])
def home():
    return "<h1>Local API Ready</p>"


app.register_blueprint(api, url_prefix="/api")
app.register_blueprint(home_api, url_prefix="/api/home")
if environ.get("ENV") != "production":
    app.run(
        host=environ.get("FLOWROME_SERVER_FLASK_HOST"),
        port=int(environ.get("FLOWROME_SERVER_FLASK_PORT")),
    )
