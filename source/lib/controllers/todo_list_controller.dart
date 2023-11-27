import 'dart:html';

import 'package:todo_app/models/todo_model.dart';

void main() {
  BodyElement body = (document.querySelector("#todo-view") as BodyElement)
      ..children.add(window.sessionStorage["todo_id"] == null
          ? TodoModel.empty
          : DivElement()); // TODO: get by id
}