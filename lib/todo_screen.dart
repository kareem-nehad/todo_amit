import 'package:flutter/material.dart';
import 'package:todo_amit/shared_preferences.dart';
import 'package:todo_amit/task_model.dart';

List<TaskModel> tasks = [];
List<String> tasksTitles = [];
List<String> finishedTasksTitles = [];
TextEditingController taskNameController = TextEditingController();
TextEditingController taskSubtitleController = TextEditingController();

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo Screen'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(tasks.length, (index) {
            return CheckboxListTile(
              value: tasks[index].isDone,
              title: Text(
                tasks[index].title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  decoration: tasks[index].isDone == false ? TextDecoration.none : TextDecoration.lineThrough,
                ),
              ),
              subtitle: Text(
                tasks[index].subtitle,
              ),
              onChanged: (choice) {
                tasks[index].isDone = choice!;
                if (choice == true) {
                  finishedTasksTitles.add(tasks[index].title);
                  Preferences.setFinishedTasks(finishedTasksTitles);
                }
                setState(() {});
              },
            );
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // addTask('Task', 'subtitle');
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return BottomSheet(
                onSubmit: () {
                  tasks.add(
                    TaskModel(
                      title: taskNameController.text,
                      subtitle: taskSubtitleController.text,
                    ),
                  );
                  tasksTitles.add(taskNameController.text);
                  print(tasks.last.isDone);
                  Preferences.setList(tasksTitles);
                  setState(() {

                  });
                },
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (Preferences.getList() != null) {
      tasksTitles = Preferences.getList()!;
    }

    if(Preferences.getFinishedTasks() != null) {
      finishedTasksTitles = Preferences.getFinishedTasks()!;
    }

    tasks = List.generate(tasksTitles.length, (index) {
      if (finishedTasksTitles.contains(tasksTitles[index])) {
        return TaskModel(title: tasksTitles[index], subtitle: '', isDone: true);
      } else {
        return TaskModel(title: tasksTitles[index], subtitle: '');
      }
    });
  }
}

class BottomSheet extends StatefulWidget {
  final void Function() onSubmit;

  const BottomSheet({
    super.key,
    required this.onSubmit,
  });

  @override
  State<BottomSheet> createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SizedBox(height: 40),
          const Text('Task Name'),
          TextFormField(
            controller: taskNameController,
          ),
          const SizedBox(height: 30),
          const Text('Task Subtitle'),
          TextFormField(
            controller: taskSubtitleController,
          ),
          const SizedBox(height: 30),
          Center(
            child: ElevatedButton(
              onPressed: () {
                widget.onSubmit();
                Navigator.pop(context);
              },
              child: const Text('Submit'),
            ),
          )
        ],
      ),
    );
  }
}

// tasks.add(
//   TaskModel(
//     title: taskNameController.text,
//     subtitle: taskSubtitleController.text,
//   ),
// );
// setState(() {
//
// });
// Navigator.pop(context);
