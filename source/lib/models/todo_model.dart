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
        title = (element.children[0].children[0] as HeadingElement).text!,
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

  DivElement get view => DivElement()
      ..classes.add('todo')
      ..setAttribute('todo-id', id ?? 'null')
      ..children.addAll(<Element>[
        LabelElement()
          ..text = "Tittle: "
          ..children.add(HeadingElement.h3()
            ..contentEditable = "true"
            ..text = title)
      ] +
          checkFields.map((field) => field.buildElement).toList());

  DivElement get card => DivElement()
    ..classes.add("card")
    ..onClick.listen((event) {
      window.sessionStorage["todo_id"] = id.toString();
      window.location.href = 'todo_list.html';
    })
    ..children.addAll([
      HeadingElement.h6()
        ..text = title,
      Element.ul()
        ..children.addAll([
          for (var checkField in checkFields.take(3)) Element.li()
            ..text = ((List<String> content) => "${content
                .take(2)
                .toList()
                .join(' ')} ${content.length > 2 ? ' ...' : ''}")
              (checkField.content.split(' '))
        ])
    ]);

  dynamic get json => {
    "id": id,
    "title": title,
    "checkFields": checkFields
        .map((field) => field.json)
        .toList(),
  };
}