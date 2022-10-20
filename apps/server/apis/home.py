from flask import Blueprint
from flask_cors import cross_origin

from utilities.classes import Response

home_api = Blueprint("home", __name__)


@home_api.route("/", methods=["GET"])
@cross_origin()
def home():
    response = Response(200, {"helloWorld": "Hello i'm the response data from flask FLOACT server"}).read()
    return response
