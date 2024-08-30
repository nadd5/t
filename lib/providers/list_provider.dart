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


/*import 'package:flutter/material.dart';
import 'package:todoappp/firebase_utils.dart';
import 'package:todoappp/model/task.dart';

class ListProvider extends ChangeNotifier {
  List<Task> tasksList = [];
  var selectDate = DateTime.now();
  

  void getAllTasksFromFireStore() async {
    var querySnapshot = await FirebaseUtils.getTasksCollection().get();
    tasksList = querySnapshot.docs.map((doc) {
    notifyListeners();
      return doc.data();
    }).toList();
    notifyListeners();
    /*tasksList = tasksList.where((task) {
      if (selectDate.day == task.dateTime.day &&
          selectDate.month == task.dateTime.month &&
          selectDate.year == task.dateTime.year) {
        return true;
      }
      notifyListeners();
      return false;
    }).toList();*/

    tasksList.sort((Task task1, Task task2){
      return task1.dateTime.compareTo(task2.dateTime);
      
    });

    notifyListeners();
  }

  void changeSelectDate(DateTime newDate) {
    selectDate = newDate;
    getAllTasksFromFireStore();
    //notifyListeners();
    notifyListeners();
  }
  
}*/
