import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management/providers/todo_provider.dart';
import 'package:task_management/screens/add_task_screen.dart';
import 'package:task_management/widgets/todo_action.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
                Consumer<TodoProvider>(
                    builder: (context, todoProvider, child) => SliverAppBar(
                          expandedHeight: 160.0,
                          centerTitle: true,
                          actions: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Theme(
                                    data: Theme.of(context).copyWith(
                                      canvasColor: Colors.deepPurpleAccent,
                                    ),
                                    child: DropdownButton<String>(
                                      icon: const Icon(
                                        Icons.filter_alt_outlined,
                                        color: Colors.white,
                                      ),
                                      style:
                                          const TextStyle(color: Colors.white),
                                      value: todoProvider.filter,
                                      underline: const Text(""),
                                      items: <String>[
                                        'Show all',
                                        'Completed',
                                        'Incomplete'
                                      ].map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value,
                                              style: const TextStyle(
                                                  color: Colors.white)),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) => todoProvider
                                          .filterTaskList(newValue!),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                          flexibleSpace: FlexibleSpaceBar(
                            title: Text(
                              "${todoProvider.allTasks.length} Tasks",
                              style: const TextStyle(fontSize: 30.0),
                            ),
                            centerTitle: false,
                            titlePadding: const EdgeInsets.only(
                                top: 0.0, left: 50.0, bottom: 50.0),
                          ),
                        ))
              ],
          body: TodoAction()),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => AddTaskScreen())),
        tooltip: "Add a todo",
        child: const Icon(Icons.add),
      ),
    );
  }
}
