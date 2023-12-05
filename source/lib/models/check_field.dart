import 'dart:html';

class CheckField {
  bool done;
  String content;

  CheckField.empty()
      : done = false,
        content = "";

  CheckField({this.done = false, required this.content});

  CheckField.fromJson(json)
      : content = json['content'],
        done = json['done'];

  CheckField.fromElement(Element element)
      : done = (element.querySelector('input[type="checkbox"]') as InputElement)
            .checked ?? false,
        content = (element.querySelector('p') as ParagraphElement)
            .text ?? '';

  DivElement get buildElement => DivElement()
      ..classes.add("check-field")
      ..children.addAll(<Element>[
        InputElement(type: "checkbox")
          ..checked = done,
        ParagraphElement()
          ..contentEditable = "true"
          ..text = content
      ]);

  dynamic get json => {
    "done": done,
    "content": content
  };
}