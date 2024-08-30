import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todoappp/appcolor.dart';
import 'package:todoappp/model/task.dart';
import 'package:todoappp/providers/list_provider.dart';

class TaskListItem extends StatelessWidget {
  final Task task;

  TaskListItem({required this.task});

  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<ListProvider>(context);

    return Container(
      margin: EdgeInsets.all(12),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.25,
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(15),
              onPressed: (context) {
                listProvider.deleteTask(task);
              },
              backgroundColor: appcolor.redcolor,
              foregroundColor: appcolor.whitecolor,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () => _showEditTaskDialog(context, task, listProvider),
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: appcolor.whitecolor,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.all(15),
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: 4,
                  color: appcolor.primarycolor,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        task.title,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: task.isDone
                                  ? Colors.green
                                  : appcolor.primarycolor,
                              decoration: task.isDone
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        task.description,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: task.isDone
                                  ? Colors.green
                                  : appcolor.primarycolor,
                              decoration: task.isDone
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                      ),
                    ],
                  ),
                ),
                Checkbox(
                  value: task.isDone,
                  onChanged: (bool? value) {
                    task.isDone = value ?? false;
                    listProvider.updateTask(task);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showEditTaskDialog(BuildContext context, Task task, ListProvider listProvider) {
    showDialog(
      context: context,
      builder: (context) {
        final titleController = TextEditingController(text: task.title);
        final descriptionController = TextEditingController(text: task.description);

        return AlertDialog(
          title: Text('Edit Task'),
          content: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                task.title = titleController.text;
                task.description = descriptionController.text;
                listProvider.updateTask(task);
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
  void _markTaskAsDone(Task task, ListProvider listProvider) {
    task.isDone = true;
    listProvider.updateTask(task);
  }

