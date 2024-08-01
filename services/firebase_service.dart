import 'package:firebase_database/firebase_database.dart';
import '../models/task.dart';

class FirebaseService {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  Stream<List<Task>> getTasksForVolunteer(String volunteerId) {
    return _dbRef
        .child('tasks')
        .orderByChild('assignedVolunteer')
        .equalTo(volunteerId)
        .onValue
        .map((event) {
      final tasks = <Task>[];
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        data.forEach((key, value) {
          tasks.add(Task.fromMap(Map<String, dynamic>.from(value)));
        });
      }
      return tasks;
    });
  }

  Stream<List<Task>> getAllTasks() {
    return _dbRef.child('tasks').onValue.map((event) {
      final tasks = <Task>[];
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        data.forEach((key, value) {
          tasks.add(Task.fromMap(Map<String, dynamic>.from(value)));
        });
      }
      return tasks;
    });
  }

  Future<void> markTaskAsDone(String taskId) async {
    await _dbRef.child('tasks/$taskId').update({'status': 'Done'});
  }

  Future<void> deleteTask(String taskId) async {
    await _dbRef.child('tasks/$taskId').remove();
  }
}
