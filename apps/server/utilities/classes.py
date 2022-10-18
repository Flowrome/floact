from json import dumps


class Response:
    def __init__(self, code, data):
        self.code = code
        self.data = data
        pass

    def read(self):
        return dumps(self, default=lambda o: o.__dict__, sort_keys=True, indent=4)
