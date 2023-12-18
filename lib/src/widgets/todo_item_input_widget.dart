import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/src/state/todo_state.dart';

class TodoItemInput extends StatefulWidget {
  const TodoItemInput({super.key, this.itemID});
  final String? itemID;

  @override
  State<TodoItemInput> createState() => _TodoItemInputState();
}

class _TodoItemInputState extends State<TodoItemInput> {
  late TextEditingController titleController;
  late TextEditingController descController;
  bool creating = true;
  void submit() {
    final String title = titleController.text;
    final String desc = descController.text;
    final state = Provider.of<TodoState>(context, listen: false);
    if (creating) {
      state.createItem(
        title: title,
        description: desc,
      );
    } else {
      // editing
      state.editItem(
        itemID: widget.itemID!,
        title: title,
        desc: desc,
      );
    }
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();

    final String title;
    final String desc;
    final state = Provider.of<TodoState>(context, listen: false);

    if (widget.itemID != null) {
      creating = false;
      final item = state.getByID(widget.itemID!);
      if (item != null) {
        title = item.title;
        desc = item.description;
      } else {
        // ! ERROR
        title = 'ERROR ERROR BAD';
        desc = 'ERROR ERROR BAD';
      }
    } else {
      title = '';
      desc = '';
    }

    titleController = TextEditingController(text: title);
    descController = TextEditingController(text: desc);
  }

  @override
  Widget build(BuildContext context) {
    // final state = Provider.of<TodoState>(context);

    // Deleted item
    // if (item == null) {
    //   return Container(
    //     padding: const EdgeInsets.all(8.0),
    //     child: const Text('Deleted item'),
    //   );
    // }

    return AlertDialog(
      title: const Text('New entry'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            autofocus: true,
            decoration: const InputDecoration(hintText: 'Title'),
          ),
          TextField(
            controller: descController,
            decoration:
                const InputDecoration(hintText: 'Description (optional)'),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: submit,
          icon: const Icon(Icons.cancel_outlined),
        ),
        IconButton(
          onPressed: submit,
          icon: const Icon(Icons.add_task),
        ),
      ],
      actionsAlignment: MainAxisAlignment.spaceBetween,
    );
  }
}
