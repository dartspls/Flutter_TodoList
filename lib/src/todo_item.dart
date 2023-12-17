class TodoItem {
  TodoItem({required String title, String? description})
      : created = DateTime.now(),
        _modiied = DateTime.now() {
    _title = title;
    _description = description;
  }

  final DateTime created;

  String _title = '';
  String? _description;
  bool _done = false;
  bool _pinned = false;
  DateTime _modiied;

  void changeTitle(String newTitle) {
    _title = newTitle;
  }

  void setDone(bool val) {
    _done = val;
  }

  void setPinned(bool val) {
    _pinned = val;
  }

  void modify(DateTime dt) {
    _modiied = dt;
  }

  String get title => _title;
  String get description => _description ?? '';
  bool get isDone => _done;
  bool get pinned => _pinned;
  DateTime get modified => _modiied;
}
