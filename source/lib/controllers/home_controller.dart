import 'dart:html';

import '../data/data_connector.dart';

void main() async {
  (document.querySelector('#todos')! as DivElement)
      .children.addAll((await DataConnector.getAll())
      .map((el) => DivElement()
        ..classes.add("card")
        ..text = el.title
        ..setAttribute('todo-id', el.id ?? 'null'))
      .map((div) => div
        ..onClick.listen((event) {
          window.sessionStorage["todo_id"] =
              div.getAttribute("todo-id") ?? "null";
          window.location.href = 'todo_list.html';
        })));

  (document.querySelector('#add-button')! as ButtonElement)
      .onClick.listen((event) {
        window.sessionStorage.remove("todo_id");
        window.location.href = 'todo_list.html';
  });
}