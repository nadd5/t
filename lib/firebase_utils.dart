import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoappp/model/my_user.dart';
import 'package:todoappp/model/task.dart';

class FirebaseUtils {
  static CollectionReference<Task> getTasksCollection(String uId) {
    return getUsersCollection().doc(uId)
        .collection(Task.collectionName)
        .withConverter<Task>(
            fromFirestore: ((snapshot, options) =>
                Task.fromFireStore(snapshot.data()!)),
            toFirestore: (task, options) => task.toFirestore());
  }

  static Future<void> addTaskToFirebase(Task task,String uId) {
    var taskCollection = getTasksCollection(uId);
    var taskDocRef = taskCollection.doc();
    task.id = taskDocRef.id;
    return taskDocRef.set(task);
  }

  static Future<void> deleteTaskFromFireStore(Task task,String uId) {
    return getTasksCollection(uId).doc(task.id).delete();
  }

  static Future<void> updateTaskInFirebase(Task task,String uId) async {
    await getTasksCollection(uId).doc(task.id).set(task);
  }

  static CollectionReference<MyUser> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
            fromFirestore: ((snapshot, options) =>
                MyUser.fromFireStore(snapshot.data()!)),
            toFirestore: (user, options) => user.ToFirestore());
  }

  static Future<void> addUserToFireStore(MyUser myUser) {
    return getUsersCollection().doc(myUser.id).set(myUser);
  }

  static Future<MyUser?> readUserFromFireStore(String uId) async {
    var snapshot = await getUsersCollection().doc(uId).get();
    return snapshot.data();
  }
}

/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoappp/model/task.dart';

class FirebaseUtils {
  static CollectionReference<Task> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection(Task.collectionName)
        .withConverter<Task>(
            fromFirestore: ((snapshot, options) =>
                Task.fromFireStore(snapshot.data()!)),
            toFirestore: (task, options) => task.toFirestore());
  }

  static Future<void> addTaskToFirebase(Task task) {
    var taskCollection = getTasksCollection();
    var taskDocRef = taskCollection.doc();
    task.id = taskDocRef.id;
    return taskDocRef.set(task);
  }

  static Future<void>deleteTaskFromFireStore(Task task) {
    return getTasksCollection().doc(task.id).delete();
  }

  static updateTaskInFirebase(task) {}
}*/

/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoappp/model/task.dart';

class FirebaseUtils {
  static CollectionReference<Task> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection(Task.collectionName)
        .withConverter<Task>(
            fromFirestore: ((snapshot, options) =>
                Task.fromFireStore(snapshot.data()!)),
            toFirestore: (task, options) => task.toFirestore());
  }

  static Future<void> addTaskToFirebase(Task task) {
    var taskCollection = getTasksCollection();
    var taskDocRef = taskCollection.doc();
    task.id = taskDocRef.id;
    return taskDocRef.set(task);
  }

  static updateTaskInFirebase(task) {}
}
*/


/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoappp/model/task.dart';

class FirebaseUtils {
  static CollectionReference<Task> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection(Task.collectionName)
        .withConverter<Task>(
            fromFirestore: ((snapshot, options) =>
                Task.fromFireStore(snapshot.data()!)),
            toFirestore: (task, options) => task.toFirestore());
  }

  static Future<void> addTaskToFirebase(Task task) {
    var taskCollection = getTasksCollection();
    var taskDocRef = taskCollection.doc();
    task.id = taskDocRef.id;
    return taskDocRef.set(task);
  }

  static Future<void> deleteTaskFromFireStore(Task task) {
    return getTasksCollection().doc(task.id).delete();
  }

  static Future<void> updateTaskInFirebase(Task task) {
    return getTasksCollection().doc(task.id).set(task);
  }
}

*/