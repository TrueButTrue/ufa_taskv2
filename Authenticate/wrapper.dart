import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ufa_task/Authenticate/authenticate.dart';
import 'package:ufa_task/Screen/activity_assignment_screen.dart';
import 'package:ufa_task/models/users.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users?>(context);

    // Return either the ActivityAssignmentScreen or Authenticate widget
    if (user == null) {
      return const Authenticate();
    } else {
      return const ActivityAssignmentScreen();
    }
  }
}
