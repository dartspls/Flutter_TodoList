
import 'package:flutter/material.dart';
import 'package:todo/src/todo_item.dart';

class TodoState with ChangeNotifier {
  List<TodoItem> items = [];
}