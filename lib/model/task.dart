import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  static const String collectionName = 'tasks';

  String id;
  String title;
  String description;
  DateTime dateTime;
  bool isDone;

  Task({
    this.id = '',
    required this.title,
    required this.dateTime,
    required this.description,
    this.isDone = false,
  });

  factory Task.fromFireStore(Map<String, dynamic> data) {
    final id = data['id'] ?? '';
    final title = data['title'] ?? '';
    final description = data['description'] ?? '';
    final isDone = data['isDone'] ?? false;

    // Ensure dateTime field is correctly handled
    final dateTime = data['dateTime'] is Timestamp
        ? (data['dateTime'] as Timestamp).toDate()
        : DateTime.now();

    return Task(
      id: id,
      title: title,
      description: description,
      dateTime: dateTime,
      isDone: isDone,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dateTime': Timestamp.fromDate(dateTime),
      'isDone': isDone,
    };
  }
}
