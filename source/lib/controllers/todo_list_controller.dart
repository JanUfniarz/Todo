import 'dart:html';

import 'package:todo_app/data/data_manager.dart';
import 'package:todo_app/models/todo_model.dart';

void main() {
  int? id = window.sessionStorage["todo_id"] != null
      ? int.parse(window.sessionStorage["todo_id"]!)
      : null;
  DivElement todoView = (document.querySelector("#todo-view") as DivElement)
      ..children.add(model(id).buildElement);

  DivElement addField = (document.querySelector("#add-field") as DivElement);
  (addField.children[1] as ButtonElement).onClick.listen((event) {
    todoView.children.add(
        CheckField(
            content: (addField.children[0] as TextInputElement).value!
        ).buildElement
    );
  });
  (addField.children[0] as TextInputElement).value;
}

TodoModel model(int? id) => id == null
    ? TodoModel.empty()
    : DataManager().getByID(id);