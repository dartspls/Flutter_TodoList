import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo/firebase_options.dart';
import 'package:todo/src/state/todo_item.dart';

class TodoState with ChangeNotifier {
  TodoState() {
    _init();
  }
  Map<String, TodoItem> items = {};
  bool _pinnedExp = true;
  bool _openExp = true;
  bool _doneExp = false;
  FirebaseFirestore get _db => FirebaseFirestore.instance;

  void _init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    final data =
        (await _db.collection('Tasks').doc('PLACEHOLDER DOCUMENT ID').get())
            .data();
    if (data == null) return;
    final item = TodoItem.fromJson(data);
    items[item.id] = item;
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

  bool get pinnedExp => _pinnedExp;
  bool get openExp => _openExp;
  bool get doneExp => _doneExp;

  void togglePinnedExp() {
    _pinnedExp = !_pinnedExp;
    notifyListeners();
  }

  void toggleOpenExp() {
    _openExp = !_openExp;
    notifyListeners();
  }

  void toggleDoneExp() {
    _doneExp = !_doneExp;
    notifyListeners();
  }

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

    // only update if new information differs from old
    final String original = '${item?.title}${item?.description}';
    final String changed = '$title$desc';
    if (original == changed) return;

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
