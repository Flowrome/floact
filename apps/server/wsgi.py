from os import environ
from posixpath import abspath

from dotenv import load_dotenv
from app import app

env = environ.get("ENV")

apix_path = environ.get("APIX_PATH", ".")

load_dotenv(dotenv_path=abspath(f"{apix_path}/envs/.env.{env}"))

if __name__ == "__main__":
    app.run(
        host=environ.get("FLOWROME_SERVER_FLASK_HOST"),
        port=int(environ.get("FLOWROME_SERVER_FLASK_PORT")),
    )
