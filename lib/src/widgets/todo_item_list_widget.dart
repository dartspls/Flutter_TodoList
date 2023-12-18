import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/src/widgets/todo_item_widget.dart';
import 'package:todo/src/state/todo_state.dart';

class TodoItemList extends StatelessWidget {
  const TodoItemList({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<TodoState>(context);
    return ListView(
      children: [
        ExpansionTile(
          key: const PageStorageKey('pinned'),
          initiallyExpanded: true,
          title: const Text('Pinned'),
          children:
              state.pinnedItems.map((e) => TodoTile(itemID: e.id)).toList(),
        ),
        ExpansionTile(
          key: const PageStorageKey('open'),
          initiallyExpanded: true,
          title: const Text('Open'),
          children: state.openItems.map((e) => TodoTile(itemID: e.id)).toList(),
        ),
        ExpansionTile(
          key: const PageStorageKey('done'),
          initiallyExpanded: false,
          title: const Text('Done'),
          children: state.doneItems.map((e) => TodoTile(itemID: e.id)).toList(),
        ),
      ],
    );
  }
}
