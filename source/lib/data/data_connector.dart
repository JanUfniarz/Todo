import 'dart:convert';
import 'dart:html';
import 'package:http/http.dart' as http;

import '../models/todo_model.dart';


class DataConnector {
  static String url = "http://127.0.0.1:5000/todo/";
  static Map<String, String> headers =
    {"Content-Type": "application/json; charset=UTF-8"};

  static Future<void> save(TodoModel todo) async =>
      await http.post(Uri.parse(url), body: jsonEncode(todo.json), headers: headers);

  static Future<TodoModel> getByID(int id) async =>
      ((http. Response response) => response.statusCode == 200
          ? ((Map<String, dynamic> json) => json.containsKey("content")
            ? TodoModel.fromJson(json["content"])
            : throw Exception(json["message"]))
        (jsonDecode(utf8.decode(response.bodyBytes)))
          : throw Exception("connection error\ncode: ${response.statusCode}"))
        (await http.get(Uri.parse("$url?id=$id"), headers: headers));

  static Future<List<TodoModel>> getAll() async => ((List<TodoModel> models) {
    window.sessionStorage["saved_id"] = (models
        .map((el) => el.id)
        .reduce((x, y) => x! > y! ? x : y)! + 1)
        .toString();
    return models;
  })((jsonDecode(utf8.decode(
      (await http.get(Uri.parse(url), headers: headers)).bodyBytes))["content"] as List<dynamic>)
      .map((el) => TodoModel.fromJson(el)).toList());
}