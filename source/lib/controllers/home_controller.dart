import 'dart:html';

import '../data/data_connector.dart';

void main() async {
  (document.querySelector('#todos')! as DivElement)
      .children.addAll((await DataConnector.getAll())
      .map((el) => el.card));

  (document.querySelector('#add-button')! as ButtonElement)
      .onClick.listen((event) {
        window.sessionStorage.remove("todo_id");
        window.location.href = 'todo_list.html';
  });
}