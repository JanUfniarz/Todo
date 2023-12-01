import 'dart:html';

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
        content = (element.querySelector('input[type="text"]') as TextInputElement)
            .value ?? '';

  DivElement get buildElement => DivElement()
      ..classes.add("check-field")
      ..children.addAll(<Element>[
        InputElement(type: "checkbox")
          ..checked = done,
        TextInputElement()..value = content
      ]);

  dynamic get json => {
    "done": done,
    "content": content
  };
}