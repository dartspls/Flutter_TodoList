import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/src/widgets/todo_item_input_widget.dart';
import 'package:todo/src/state/todo_state.dart';

class TodoTile extends StatelessWidget {
  const TodoTile({super.key, required this.itemID});
  final String itemID;
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<TodoState>(context);
    final item = state.getByID(itemID);
    if (item == null) {
      return const ListTile(
        title: Text('Deleted item'),
      );
    }
    return ListTile(
      title: Text(item.title),
      subtitle: Text(item.description),
      leading: Checkbox(
        value: item.isDone,
        onChanged: (_) => state.toggleItem(itemID),
      ),
      onTap: () => showDialog(
        context: context,
        builder: (context) => TodoItemInput(itemID: item.id),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          state.deleteItem(id: itemID);
        },
      ),
    );
  }
}
