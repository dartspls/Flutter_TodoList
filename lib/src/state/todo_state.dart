import 'package:flutter/material.dart';
import 'package:todo/src/state/todo_item.dart';

class TodoState with ChangeNotifier {
  TodoState() {
    _init();
  }
  Map<String, TodoItem> items = {};

  void _init() async {
    final item1 = TodoItem(title: 'Testing 1', description: 'The first item');
    final item2 = TodoItem(title: 'Testing 2');
    items[item1.id] = item1;
    items[item2.id] = item2;

    for (int i = 0; i < 100; i++) {
      final item = TodoItem(title: 'Item number: $i');
      items[item.id] = item;
      await Future.delayed(const Duration(milliseconds: 1));
    }
    notifyListeners();
  }

  List<TodoItem> get asList =>
      items.values.toList()..sort((a, b) => b.created.compareTo(a.created));

  List<TodoItem> get doneItems =>
      items.values.where((element) => element.isDone).toList()
        ..sort((a, b) => b.modified.compareTo(a.modified));

  List<TodoItem> get openItems => items.values
      .where((element) => !element.isDone && !element.pinned)
      .toList()
    ..sort((a, b) => b.modified.compareTo(a.modified));

  List<TodoItem> get pinnedItems => items.values
      .where((element) => !element.isDone && element.pinned)
      .toList()
    ..sort((a, b) => b.modified.compareTo(a.modified));

  void createItem({required String title, String? description}) {
    TodoItem item = TodoItem(title: title, description: description);
    items[item.id] = item;
    notifyListeners();
  }

  void deleteItem({required String id}) {
    items.remove(id);
    notifyListeners();
  }

  void togglePinItem({required String id}) {
    final item = items[id];
    item?.setPinned(!item.pinned);
    notifyListeners();
  }

  void editItem(
      {required String itemID, required String title, required String desc}) {
    final item = getByID(itemID);
    item?.changeTitle(title);
    item?.changeDesc(desc);
    notifyListeners();
  }

  TodoItem? getByID(String id) => items[id];

  void toggleItem(String id) {
    getByID(id)?.toggleDone();
    notifyListeners();
  }
}
