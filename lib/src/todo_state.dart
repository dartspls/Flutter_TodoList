import 'package:flutter/material.dart';
import 'package:todo/src/todo_item.dart';

class TodoState with ChangeNotifier {
  List<TodoItem> items = [
    TodoItem(title: 'Testing 1', description: 'The first item'),
    TodoItem(title: 'Testing 2')
  ];

  void createItem({required String title, String? description}) {
    TodoItem item = TodoItem(title: title, description: description);
    items.add(item);
    notifyListeners();
  }

  TodoItem? getByID(String id) =>
      items.where((element) => element.id == id).firstOrNull;

  void toggleItem(String id) {
    getByID(id)?.toggleDone();
    notifyListeners();
  }
}
