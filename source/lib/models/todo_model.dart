import 'dart:html';

import 'check_field.dart';

class TodoModel {
  int? id;
  String title;
  List<CheckField> checkFields;

  TodoModel.empty()
      : id = null,
        title = "Todo",
        checkFields = [];

  TodoModel({this.id, this.title = "Todo", List<CheckField>? checkFields})
      : checkFields = checkFields ?? [] {
    _init();
  }

  TodoModel.fromElement(Element element)
      : id = int.tryParse(element.getAttribute('todo-id') ?? 'null'),
        title = (element.children[0].children[0] as TextInputElement).value!,
        checkFields = element
            .querySelectorAll('.check-field')
            .map((fieldDiv) => CheckField.fromElement(fieldDiv))
            .toList() {
    _init();
  }

  TodoModel.fromJson(json)
      : id = json['id'],
        title = json['title'],
        checkFields = (json['checkFields'] as List<dynamic>)
            .map((field) => CheckField.fromJson(field))
            .toList() {
    _init();
  }

  void _init() {
    id ??= int.parse(window.sessionStorage["saved_id"] ?? "0");
    window.sessionStorage["saved_id"] = (id! + 1).toString();
  }

  DivElement get buildElement => DivElement()
      ..classes.add('todo')
      ..setAttribute('todo-id', id ?? 'null')
      ..children.addAll(<Element>[
        LabelElement()
          ..text = "Tittle: "
          ..children.add(TextInputElement()
            ..value = title)
      ] +
          checkFields.map((field) => field.buildElement).toList());

  dynamic get json => {
    "id": id,
    "title": title,
    "checkFields": checkFields
        .map((field) => field.json)
        .toList(),
  };
}