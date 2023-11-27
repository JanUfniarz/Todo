import 'dart:html';
import 'package:todo_app/todo_model.dart';

void main() {
  DivElement todos = (document.querySelector('#todos')! as DivElement)
      ..children.add(TodoModel(
          id: 4, title: "Tytuł testowego",
          checkFields: [
            CheckField(content: "testowe"
            )
          ]).div);
  ButtonElement addButton = (document.querySelector('#add-button')! as ButtonElement)
      ..onClick.listen((event) {
        window.location.href = 'todo_list.html';
        DivElement todoView = (document.querySelector('#todo-view') as DivElement)
            ..children.addAll(todos.children);
  });
}


void test(Element container) => container.children.add(
    TodoModel(
        id: 4, title: "Tytuł testowego",
        checkFields: [
          CheckField(content: "testowe"
          )
        ]).div);