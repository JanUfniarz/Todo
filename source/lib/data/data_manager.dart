import 'dart:io';
import 'dart:convert';
import 'package:path/path.dart' as path;
import 'package:todo_app/models/todo_model.dart';

class DataManager {
  final File _file = File(path.join(Directory.current.path, "data.json"));

  List<dynamic> get data => jsonDecode(_file.readAsStringSync());

  void addTodo(todo) => _file.writeAsStringSync(jsonEncode(data + [todo]));

  TodoModel getByID(int sessionStorage) {}
}
