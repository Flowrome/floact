from crypt import methods
from flask import Blueprint
from flask_cors import cross_origin

from utilities.classes import Response

home_api = Blueprint("home", __name__)


@home_api.route("/", methods=["GET"])
@cross_origin()
def home():
    response = Response(200, {"home": "ciao"}).read()
    return response
