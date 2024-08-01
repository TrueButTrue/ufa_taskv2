import 'package:flutter/material.dart';
import 'volunteer_dashboard_screen.dart';
import '../authenticate/authenticate.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Hard-coded volunteer ID for testing purposes
                const volunteerId = 'testVolunteerId';
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const VolunteerDashboardScreen(volunteerId: volunteerId),
                  ),
                );
              },
              child: const Text('Volunteer'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Authenticate()),
                );
              },
              child: const Text('Admin'),
            ),
          ],
        ),
      ),
    );
  }
}
