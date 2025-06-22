import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// add show/hide alert dialog logic class using Cubit
class ShowHideAlertDialogLogic extends Cubit<bool> {
  ShowHideAlertDialogLogic() : super(false);

  // logic function
  void showHideAlertDialog() {
    emit(!state);
  }
}

// add task to tasklist logic class using Cubit
class AddTaskLogic extends Cubit<Map<String, dynamic>> {
  AddTaskLogic()
      : super({
          'taskName': '',
          'error': null,
          'taskList': [],
        });

  // logic function
  void addTask(String taskName) {
    emit({
      'taskName': taskName,
      'error': null,
    });
  }

  // logic function to add task to task list
  void addTaskToTaskList(String taskName) {
    emit({
      'taskName': taskName,
      'error': null,
      'taskList': [taskName],
    });
  }
}

// todo list page
class ToDoListPage extends StatelessWidget {
  const ToDoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // initial state

    final TextEditingController taskNameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Name list')),
      // build the ui with BlocBuilder
      body: BlocBuilder<AddTaskLogic, Map<String, dynamic>>(
          builder: (context, data) {
        if (data['tasklist'] == null) {
          return const Center(child: Text('No tasks added'));
        } else {
          return ListView.builder(itemBuilder: (context, index) {
            return ListTile(
              title: Text(data['taskList'][index]),
            );
          });
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // context.read<ShowHideAlertDialogLogic>().showHideAlertDialog();
          // show alert dialog
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Add name'),
                content: TextField(
                  controller: taskNameController,
                  decoration: const InputDecoration(hintText: 'Enter name'),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel')),
                  TextButton(
                      onPressed: () {
                        // add task to bloc logic
                        print(taskNameController.text);
                        Navigator.pop(context);
                      },
                      child: const Text('Add')),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
