import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/src/state/todo_state.dart';
import 'package:todo/src/widgets/todo_item_widget.dart';

class TodoItemCol extends StatelessWidget {
  const TodoItemCol({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<TodoState>(context);
    return Column(
      children: [
        ListTile(
          tileColor: Colors.yellow,
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('${state.pinnedItems.length} items'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                    state.pinnedExp ? Icons.expand_less : Icons.expand_more),
              ),
            ],
          ),
          title: const Text('Pinned'),
          onTap: () => state.togglePinnedExp(),
        ),
        Expanded(
          flex: state.pinnedExp ? 100 : 1,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return TodoTile(
                itemID: state.pinnedItems[index].id,
              );
            },
            itemCount: state.pinnedExp ? state.pinnedItems.length : 0,
          ),
        ),
        ListTile(
          tileColor: Colors.blue,
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('${state.openItems.length} items'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    Icon(state.openExp ? Icons.expand_less : Icons.expand_more),
              ),
            ],
          ),
          title: const Text('Open'),
          onTap: () => state.toggleOpenExp(),
        ),
        Expanded(
          flex: state.openExp ? 100 : 1,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return TodoTile(
                itemID: state.openItems[index].id,
              );
            },
            itemCount: state.openExp ? state.openItems.length : 0,
          ),
        ),
        ListTile(
          tileColor: Colors.green,
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('${state.doneItems.length} items'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    Icon(state.doneExp ? Icons.expand_less : Icons.expand_more),
              ),
            ],
          ),
          title: const Text('Done'),
          onTap: () => state.toggleDoneExp(),
        ),
        Expanded(
          flex: (!state.pinnedExp && !state.openExp && !state.doneExp)
              ? 100
              : state.doneExp
                  ? 100
                  : 1,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return TodoTile(
                itemID: state.doneItems[index].id,
              );
            },
            itemCount: state.doneExp ? state.doneItems.length : 0,
          ),
        ),
      ],
    );
  }
}
