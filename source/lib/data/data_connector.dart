import 'dart:convert';
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
            ? json["content"]
            : throw Exception(json["message"]))
        (jsonDecode(utf8.decode(response.bodyBytes)))
          : throw Exception("connection error\ncode: ${response.statusCode}"))
        (await http.get(Uri.parse("$url?id=$id"), headers: headers));
}