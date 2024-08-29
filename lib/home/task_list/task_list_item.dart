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
                                  : null,
                            ),
                      ),
                      Text(
                        task.description,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: task.isDone
                                  ? Colors.green
                                  : appcolor.primarycolor,
                              decoration: task.isDone
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: task.isDone
                        ? Colors.transparent
                        : appcolor.primarycolor,
                  ),
                  child: task.isDone
                      ? Text(
                          "is done",
                          style: TextStyle(
                              color: Colors.green, fontWeight: FontWeight.bold),
                        )
                      : IconButton(
                          onPressed: () {
                            _markTaskAsDone(task, listProvider);
                          },
                          icon: Icon(Icons.check, size: 35),
                          color: appcolor.whitecolor,
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showEditTaskDialog(
      BuildContext context, Task task, ListProvider listProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String updatedTitle = task.title;
        String updatedDescription = task.description;

        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: appcolor.whitecolor,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Text(
                    "Edit Task",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  onChanged: (value) {
                    updatedTitle = value;
                  },
                  controller: TextEditingController(text: task.title),
                  style: TextStyle(color: Colors.black, fontSize: 12),
                  cursorColor: Colors.blue,
                  decoration: InputDecoration(
                    labelText: "Enter Task Title",
                    filled: true,
                    fillColor: Colors.transparent,
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  onChanged: (value) {
                    updatedDescription = value;
                  },
                  controller: TextEditingController(text: task.description),
                  style: TextStyle(color: Colors.black, fontSize: 12),
                  cursorColor: Colors.blue,
                  decoration: InputDecoration(
                    labelText: "Enter Task Description",
                    filled: true,
                    fillColor: Colors.transparent,
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                  maxLines: 3,
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: appcolor.primarycolor),
                      ),
                    ),
                    SizedBox(width: 8),
                    TextButton(
                      onPressed: () {
                        task.title = updatedTitle;
                        task.description = updatedDescription;
                        listProvider.updateTask(task);
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Save",
                        style: TextStyle(color: appcolor.primarycolor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _markTaskAsDone(Task task, ListProvider listProvider) {
    task.isDone = true;
    listProvider.updateTask(task);
  }
}
