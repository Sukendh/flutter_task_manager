import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_management/screens/add_task_screen.dart';
import '../providers/todo_provider.dart';

class TodoAction extends StatelessWidget {
  TodoAction({Key? key}) : super(key: key);
  final DateFormat _dateFormatter = DateFormat('MMM dd, yyyy');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<TodoProvider>(context, listen: false).getAllTask(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<TodoProvider>(
                builder: (context, todoProvider, child) => todoProvider
                        .allTasks.isEmpty
                    ? const Center(
                        child: Text("Add a Task"),
                      )
                    : ListView.builder(
                        itemCount: todoProvider.allTasks.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: ((context, index) => Container(
                              margin: const EdgeInsets.all(10.0),
                              padding: const EdgeInsets.all(10.0),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(10.0))
                              ),
                              
                              child: Row(
                                children: [
                                  Checkbox(
                                    value:
                                        todoProvider.allTasks[index].status == 0
                                            ? false
                                            : true,
                                    onChanged: ((_) => todoProvider.toggleTask(
                                        todoProvider.allTasks[index])),
                                  ),
                                  Expanded(
                                      child: InkWell(
                                    onTap: () => Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => AddTaskScreen(
                                                  task: todoProvider
                                                      .allTasks[index],
                                                ))),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          todoProvider.allTasks[index].title!,
                                          style: TextStyle(
                                              fontSize: 25.0,
                                              decoration: todoProvider
                                                          .allTasks[index]
                                                          .status ==
                                                      1
                                                  ? TextDecoration.lineThrough
                                                  : TextDecoration.none,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          todoProvider
                                              .allTasks[index].description!,
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              decoration: todoProvider
                                                          .allTasks[index]
                                                          .status ==
                                                      1
                                                  ? TextDecoration.lineThrough
                                                  : TextDecoration.none,
                                              color: Colors.grey),
                                        ),
                                        const SizedBox(height: 10.0,),
                                        Text(
                                            _dateFormatter.format(todoProvider
                                                .allTasks[index].dueDate!),
                                                
                                            style: const TextStyle(
                                                fontSize: 13.0,
                                              
                                                color: Colors.grey))
                                      ],
                                    ),
                                  )),
                                  IconButton(
                                      onPressed: () {
                                        todoProvider.deleteTask(
                                            todoProvider.allTasks[index]);
                                      },
                                      icon: const Icon(Icons.delete)),
                                ],
                              ),
                            )),
                      )));
  }
}
