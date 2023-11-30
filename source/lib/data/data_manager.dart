import 'dart:io';
import 'dart:convert';
import 'package:path/path.dart' as path;
import 'package:todo_app/models/todo_model.dart';

class DataManager {
  final File _file = File(path.join(Directory.current.path, "data.json"));

  static DataManager? _instance;
  static DataManager get instance {
    _instance ??= DataManager();
    return _instance!;
  }

  List<dynamic> get data => jsonDecode(_file.readAsStringSync());

  bool _isAvailable(int id) => data.any((el) => el["id"] == id);

  void save(TodoModel todo) => _file.writeAsStringSync(jsonEncode(_isAvailable(todo.id!)
      ? (data..[data.indexWhere((el) => el["id"] == todo.id)] = todo.json)
      : [...data, todo.json]));


  TodoModel getByID(int id) => _isAvailable(id)
      ? TodoModel.fromJson(data.firstWhere((el) => el["id"] == id))
      : throw Exception("Could not find todo with id $id");
}