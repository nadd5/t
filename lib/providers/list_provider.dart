import 'package:flutter/material.dart';
import 'package:todoappp/firebase_utils.dart';
import 'package:todoappp/model/task.dart';

class ListProvider extends ChangeNotifier {
  List<Task> tasksList = [];
  var selectedDate = DateTime.now();

  void getAllTasksFromFireStore() async {
    var querySnapshot = await FirebaseUtils.getTasksCollection().get();
    tasksList = querySnapshot.docs.map((doc) {
      return doc.data(); // Corrected method to access data
    }).toList();
    notifyListeners();
  }
}
