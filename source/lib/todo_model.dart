class TodoModel {
  static int _savedID = 0;

  int? id;
  String title;
  List<CheckField> checkFields;

  TodoModel({this.id, this.title = "Todo", List<CheckField>? checkFields})
      : checkFields = checkFields ?? [] {
    id ??= _savedID++;
  }
}

class CheckField {
  bool done;
  String content;

  CheckField({this.done = false, required this.content});
}
