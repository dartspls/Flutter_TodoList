import 'package:uuid/uuid.dart';

class TodoItem {
  TodoItem({required String title, String? description})
      : created = DateTime.now(),
        _modiied = DateTime.now(),
        id = const Uuid().v1() {
    _title = title;
    _description = description;
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
