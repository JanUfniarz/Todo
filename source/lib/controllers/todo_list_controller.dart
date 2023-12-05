import 'dart:html';

import 'package:todo_app/data/data_connector.dart';
import 'package:todo_app/models/todo_model.dart';

import '../models/check_field.dart';

Future<void> main() async {

  int? id = window.sessionStorage["todo_id"] != null
      ? int.parse(window.sessionStorage["todo_id"]!)
      : null;

  TodoModel model = id == null
      ? TodoModel.empty()
      : await DataConnector.getByID(id);

  document.title = model.title;

  DivElement todoView = (document.querySelector("#todo-view") as DivElement)
      ..children.add(model.view);

  (document.querySelector("#add-field") as ButtonElement).onClick.listen((event) =>
    todoView.children.add(CheckField.empty().buildElement));

  (document.querySelector("#save-button") as ButtonElement)
    .onClick.listen((event) async {

    await DataConnector.save(
        TodoModel.fromElement(todoView.children[0])
          ..checkFields.addAll(todoView.children
              .sublist(1)
              .map((el) => CheckField.fromElement(el))
              .toList()));

    window.location.href = 'index.html';
  });
}