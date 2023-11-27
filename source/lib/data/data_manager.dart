import 'dart:io';
import 'dart:convert';
import 'package:path/path.dart' as path;

class DataManager {
  final File _file = File(path.join(Directory.current.path, "data.json"));

  List<dynamic> get data => jsonDecode(_file.readAsStringSync());

  void addTodo(todo) => _file.writeAsStringSync(jsonEncode(data + [todo]));
}
