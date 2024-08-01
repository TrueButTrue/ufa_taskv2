import 'package:flutter/material.dart';
import '../services/firebase_service.dart';
import '../models/task.dart';

class VolunteerDashboardScreen extends StatelessWidget {
  final String volunteerId;

  const VolunteerDashboardScreen({super.key, required this.volunteerId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Volunteer Dashboard'),
      ),
      body: StreamBuilder<List<Task>>(
        stream: FirebaseService().getTasksForVolunteer(volunteerId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No tasks assigned yet.'));
          }

          final tasks = snapshot.data!;
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return ListTile(
                title: Text(task.title),
                subtitle: Text(task.description),
                trailing: Text(task.status),
                onTap: () {
                  // Navigate to task detail or perform any action
                },
              );
            },
          );
        },
      ),
    );
  }
}
