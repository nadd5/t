import 'package:flutter/material.dart';
import 'package:todoappp/firebase_utils.dart';
import 'package:todoappp/model/task.dart';

class ListProvider extends ChangeNotifier {
  List<Task> tasksList = [];
  var selectedDate = DateTime.now();

  ListProvider() {
    getAllTasksFromFireStore();
  }

  void getAllTasksFromFireStore() async {
    var querySnapshot = await FirebaseUtils.getTasksCollection().get();
    List<Task> fetchedTasksList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();

    tasksList = fetchedTasksList.where((task) {
      return selectedDate.day == task.dateTime.day &&
          selectedDate.month == task.dateTime.month &&
          selectedDate.year == task.dateTime.year;
    }).toList();

    tasksList.sort((Task task1, Task task2) {
      return task1.dateTime.compareTo(task2.dateTime);
    });

    notifyListeners(); 
  }

  void changeSelectedDate(DateTime newDate) {
    selectedDate = newDate;
    getAllTasksFromFireStore();
  }

  void addTask(Task task) async {
    await FirebaseUtils.addTaskToFirebase(task);
    getAllTasksFromFireStore();
  }

  void updateTask(Task task) async {
    await FirebaseUtils.updateTaskInFirebase(task);
    getAllTasksFromFireStore();
  }

  void deleteTask(Task task) async {
    await FirebaseUtils.deleteTaskFromFireStore(task);
    getAllTasksFromFireStore();
  }
}
