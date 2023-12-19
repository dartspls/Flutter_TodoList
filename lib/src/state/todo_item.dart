import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class TodoItem {
  TodoItem({required String title, String? description})
      : created = DateTime.now(),
        _modiied = DateTime.now(),
        id = const Uuid().v1() {
    _title = title;
    _description = description;
  }

  TodoItem._private({
    required String title,
    required String desc,
    required bool done,
    required bool pinned,
    required this.created,
    required DateTime modified,
    required this.id,
  }) : _modiied = modified {
    _title = title;
    _description = desc;
    _done = done;
    _pinned = pinned;
  }

  factory TodoItem.fromJson(Map<String, dynamic> data) {
    final String title = data['title'];
    final String desc = data['description'];
    final bool done = data['done'];
    final bool pinned = data['pinned'];
    final DateTime created = (data['created'] as Timestamp).toDate();
    final DateTime modified = (data['modified'] as Timestamp).toDate();
    final String id = data['id'];

    return TodoItem._private(
      title: title,
      desc: desc,
      done: done,
      pinned: pinned,
      created: created,
      modified: modified,
      id: id,
    );
  }

  final DateTime created;
  final String id;

  String _title = '';
  String? _description;
  bool _done = false;
  bool _pinned = false;
  DateTime _modiied;

  void changeTitle(String title) {
    _title = title;
    _modify();
  }

  void changeDesc(String desc) {
    _description = desc;
    _modify();
  }

  void toggleDone() {
    _done = !_done;
    _modify();
  }

  void setPinned(bool val) {
    _pinned = val;
  }

  void _modify() {
    _modiied = DateTime.now();
  }

  String get title => _title;
  String get description => _description ?? '';
  bool get isDone => _done;
  bool get pinned => _pinned;
  DateTime get modified => _modiied;
}
