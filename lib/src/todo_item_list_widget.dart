import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/src/todo_item_widget.dart';
import 'package:todo/src/todo_state.dart';

class TodoItemList extends StatelessWidget {
  const TodoItemList({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<TodoState>(context);
    return ListView.builder(
      itemBuilder: (context, index) {
        return TodoTile(itemID: state.items[index].id);
      },
      itemCount: state.items.length,
    );
  }
}
