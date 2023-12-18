import 'package:flutter/material.dart';
import 'package:todo/src/state/todo_item.dart';

class TodoState with ChangeNotifier {
  TodoState() {
    _init();
  }
  Map<String, TodoItem> items = {};

  void _init() {
    final item1 = TodoItem(title: 'Testing 1', description: 'The first item');
    final item2 = TodoItem(title: 'Testing 2');
    items[item1.id] = item1;
    items[item2.id] = item2;
  }

  List<TodoItem> get asList =>
      items.values.toList()..sort((a, b) => b.created.compareTo(a.created));

  void createItem({required String title, String? description}) {
    TodoItem item = TodoItem(title: title, description: description);
    items[item.id] = item;
    notifyListeners();
  }

  void deleteItem({required String id}) {
    items.remove(id);
    notifyListeners();
  }

  void editItem(
      {required String itemID, required String title, required String desc}) {
    final item = getByID(itemID);
    item?.changeTitle(title);
    item?.changeDesc(desc);
    item?.modify();
    notifyListeners();
  }

  TodoItem? getByID(String id) => items[id];

  void toggleItem(String id) {
    getByID(id)?.toggleDone();
    notifyListeners();
  }
}
