import 'dart:html';

import 'package:todo_app/data/data_connector.dart';
import 'package:todo_app/models/todo_model.dart';

import '../models/check_field.dart';

Future<void> main() async {
  int? id = window.sessionStorage["todo_id"] != null
      ? int.parse(window.sessionStorage["todo_id"]!)
      : null;
  DivElement todoView = (document.querySelector("#todo-view") as DivElement)
      ..children.add((id == null
          ? TodoModel.empty()
          : await DataConnector.getByID(id)
      ).buildElement);

  DivElement addField = (document.querySelector("#add-field") as DivElement);
  (addField.children[1] as ButtonElement).onClick.listen((event) {
    todoView.children.add(
        CheckField(
            content: (addField.children[0] as TextInputElement).value!
        ).buildElement
    );
  });
  (document.querySelector("#save-button") as ButtonElement)
      .onClick.listen((event) => DataConnector.save(
      TodoModel.fromElement(todoView.children[0])));
}