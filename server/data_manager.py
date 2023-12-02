import json
import os

from flask import Flask, request, jsonify

file_path: str = os.path.join(os.path.dirname(os.path.realpath(__file__)), "data.json")

app: Flask = Flask(__name__)


def data() -> list[dict]:
    with open(file_path, 'r') as file:
        return json.load(file)


def is_available(id_: int) -> bool:
    return any(el["id"] == id_ for el in data())


@app.after_request
def after_request(response):
    response.headers.add('Access-Control-Allow-Origin', '*')
    response.headers.add('Access-Control-Allow-Headers', 'Content-Type,Authorization')
    response.headers.add('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE')
    return response


@app.route("/todo/", methods=["POST", "PUT"])
def save():
    todo: dict = request.get_json()
    res: list[dict] = data()
    mes: str = ""
    if is_available(todo["id"]):
        res[next((i for i, el in enumerate(
            res) if el["id"] == todo["id"]), None)] = todo
        mes = "updated"
    else:
        res.append(todo)
        mes = "added"
    with open(file_path, 'w') as file:
        json.dump(res, file)
    return jsonify(dict(
        message=f"todo {todo['id']} {mes} successfully!"))


@app.route("/todo/", methods=["GET"])
def get():
    if "id" in request.args:
        id_: int = int(request.args.get('id'))
        if is_available(id_):
            return jsonify(dict(
                message=f"todo {id_} got successfully",
                content=next(el for el in data() if el["id"] == id_)))
        else:
            return jsonify(dict(
                message=f"todo {id_} do not exist"))
    else:
        return jsonify(dict(
            message=f"todos got successfully",
            content=data()))


if __name__ == "__main__":
    print("path: " + file_path)
    app.run()
