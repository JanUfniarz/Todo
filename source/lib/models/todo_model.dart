import 'dart:convert';
import 'dart:html';

class TodoModel {
  static int _savedID = 0;

  static DivElement get empty => TodoModel._empty().div;
  TodoModel._empty()
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

  TodoModel.fromDiv(Element div)
      : id = int.tryParse(div.getAttribute('todo-id') ?? 'null'),
        title = div.querySelector('p')?.text ?? '',
        checkFields = div
            .querySelectorAll('.check-field')
            .map((checkFieldDiv) => CheckField(
                  done: (checkFieldDiv.querySelector('input[type="checkbox"]')
                    as InputElement).checked ?? false,
                  content:
                      (checkFieldDiv.querySelector('p') as ParagraphElement)
                          .text ?? '',
                ))
            .toList() {
    _init();
  }

  TodoModel.fromJson(String json)
      : id = jsonDecode(json)['id'],
        title = jsonDecode(json)['title'],
        checkFields = (jsonDecode(json)['checkFields'] as List<dynamic>)
            .map((field) => CheckField(
              content: field['content'],
              done: field['done']
        )).toList() {
    _init();
  }

  void _init() => id ??= _savedID++;

  DivElement get div => DivElement()
    ..classes.add('todo')
    ..setAttribute('todo-id', id ?? 'null')
    ..children.addAll(<Element>[
          ParagraphElement()..text = 'Title: $title',
        ] +
        checkFields.map((field) {
          InputElement checkbox = InputElement(type: 'checkbox')
            ..checked = field.done;

          // Dodawanie obsługi zdarzeń dla checkbox
          checkbox.onChange
              .listen((Event event) => field.done = checkbox.checked!);

          return DivElement()
            ..classes.add('check-field')
            ..children
                .addAll([checkbox, ParagraphElement()..text = field.content]);
        }).toList());

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
}
