import 'package:flutter/material.dart';
import '../services/firebase_service.dart';
import '../models/task.dart';
import 'activity_assignment_screen.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  _AdminDashboardScreenState createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ActivityAssignmentScreen()),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<List<Task>>(
        stream: FirebaseService().getAllTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No tasks available.'));
          }

          final tasks = snapshot.data!;
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return ListTile(
                title: Text(task.title),
                subtitle: Text(task.description),
                trailing: PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'done') {
                      FirebaseService().markTaskAsDone(task.id);
                    } else if (value == 'delete') {
                      FirebaseService().deleteTask(task.id);
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return {'Mark as Done', 'Delete'}
                        .map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice == 'Mark as Done' ? 'done' : 'delete',
                        child: Text(choice),
                      );
                    })
                        .toList();
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
