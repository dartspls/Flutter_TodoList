import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/src/todo_item.dart';
import 'package:todo/src/todo_item_input_widget.dart';
import 'package:todo/src/todo_item_list_widget.dart';
import 'package:todo/src/todo_state.dart';

void main() {
  runApp(
      ChangeNotifierProvider(create: (_) => TodoState(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      home: const TodoHome(title: 'A todo list in the making'),
    );
  }
}

class TodoHome extends StatelessWidget {
  const TodoHome({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: const TodoItemList(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const TodoItemInput(),
          );
        },
      ),
    );
  }
}
