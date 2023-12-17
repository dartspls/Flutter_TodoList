class TodoItem {
  TodoItem({required String title, String? description}) {
    _title = title;
    _description = description;
  }

  String _title = '';
  String? _description;
  bool _done = false;

  void changeTitle(String newTitle) {
    _title = newTitle;
  }

  void setDone(bool val) {
    _done = val;
  }

  String get title => _title;
  String get description => _description ?? '';
  bool get isDone => _done;
}
