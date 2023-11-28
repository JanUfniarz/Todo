import 'dart:html';
import 'package:todo_app/models/todo_model.dart';

void main() {
  DivElement todos = (document.querySelector('#todos')! as DivElement)
      ..children.add(test());
  ButtonElement addButton = (document.querySelector('#add-button')! as ButtonElement)
      ..onClick.listen((event) {
        window.sessionStorage.remove("todo_id");
        window.location.href = 'todo_list.html';
  });
}


DivElement test() => TodoModel(
        id: 4, title: "Tytuł testowego",
        checkFields: [
          CheckField(content: "testowe"
          )
        ]).buildElement;