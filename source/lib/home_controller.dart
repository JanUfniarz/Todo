import 'dart:html';

import 'package:todo_app/data_manager.dart';
import 'package:todo_app/todo_model.dart';

class HomeController {
  DataManager dataManager;
  Element container;
  Element addButton;

  HomeController(
      this.dataManager,
      this.container,
      this.addButton,
  ) {
    addButton.onClick.listen((MouseEvent event) => test(container));
  }

  void merge(TodoModel todo) {}

  void test(Element container) => container.children.add(
      TodoModel(
          id: 4, title: "Tytuł testowego",
          checkFields: [
            CheckField(content: "testowe"
            )
          ]).div);
}

