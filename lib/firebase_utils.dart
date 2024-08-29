import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoappp/model/task.dart';

class FirebaseUtils {

  static CollectionReference<Task> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection(Task.collectionName)
        .withConverter<Task>(
            fromFirestore: (snapshot, options) =>
                Task.fromFireStore(snapshot.data()!), 
            toFirestore: (task, options) => task.toFirestore());
  }
  static Future<void> addTaskToFirebase(Task task) async {
    var taskCollection = getTasksCollection();
    var taskDocRef = taskCollection.doc();
    task.id = taskDocRef.id;
    await taskDocRef.set(task);
  }

 
  static Future<void> deleteTaskFromFireStore(Task task) async {
    await getTasksCollection().doc(task.id).delete();
  }

  static Future<void> updateTaskInFirebase(Task task) async {
    await getTasksCollection().doc(task.id).set(task);
  }
}
