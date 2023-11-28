import 'dart:convert';
import 'dart:html';

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
        title = element.querySelector('p')?.text ?? '',
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
            .map((field) => CheckField.fromJson(field)
        ).toList() {
    _init();
  }

  void _init() => id ??= _savedID++;

  DivElement get buildElement => DivElement()
    ..classes.add('todo')
    ..setAttribute('todo-id', id ?? 'null')
    ..children.addAll(<Element>[
      DivElement()..children.addAll(<Element>[
        ParagraphElement()..text = "Title: $title",
        TextInputElement()..placeholder = "Change title"
      ]),
    ] +
        checkFields.map((field) => field.buildElement).toList());

  String get json => jsonEncode({
        "id": id,
        "title": title,
        "checkFields": checkFields
            .map((field) => {"done": field.done, "content": field.content})
            .toList(),
      });
}

class CheckField {
  bool done;
  String content;

  CheckField({this.done = false, required this.content});

  CheckField.fromJson(json)
      : content = json['content'],
        done = json['done'];

  CheckField.fromElement(Element element)
      : done = (element.querySelector('input[type="checkbox"]')
            as InputElement).checked ?? false,
        content = (element.querySelector('p') as ParagraphElement)
            .text ?? '';

  DivElement get buildElement {
    InputElement checkbox = InputElement(type: "checkbox")
      ..checked = done;

    checkbox.onChange
        .listen((Event event) => done = checkbox.checked!);

    return DivElement()
      ..classes.add("check-field")
      ..children.addAll(<Element>[
        checkbox,
        ParagraphElement()..text = content
      ]);
  }
}
