import 'dart:convert';
import 'dart:html';

import 'check_field.dart';

class TodoModel {
  static int _savedID = 0;

  TodoModel.empty()
      : id = null,
        title = "Todo",
        checkFields = [];

  int? id;
  String title;
  List<CheckField> checkFields;

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

  TodoModel.fromJson(String json)
      : id = jsonDecode(json)['id'],
        title = jsonDecode(json)['title'],
        checkFields = (jsonDecode(json)['checkFields'] as List<dynamic>)
            .map((field) => CheckField.fromJson(field))
            .toList() {
    _init();
  }

  void _init() => id ??= _savedID++;

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