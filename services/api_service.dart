import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  List<String> volunteers = [
    'Muneeza Qureshi', 'Siraj Mohammad', 'Faraaz Husain', 'Aaahil Penwalla',
    'Mohamed Junaid Ghani', 'Sidra Dakhel', 'Ryan Vaseem',
    'Abbas Haq', 'Isra Osmani', 'Khashiya Ranginwala',
    'Anisa Ismail',
  ];

  List<String> categories = [
    'Business Analysis', 'Design', 'Programming', 'Data Analysis', 'Testing SQA',
  ];

  Map<String, List<String>> activities = {
    'Business Analysis': ['Activity 1', 'Activity 2'],
    'Design': ['Activity 3', 'Activity 4'],
    'Programming': ['Activity 5', 'Activity 6'],
    'Data Analysis': ['Create UI Activity Assignment'],
    'Testing SQA': ['Activity 7', 'Activity 8'],
  };

  Future<List<String>> fetchVolunteers() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulating a network call
    return volunteers;
  }

  Future<List<String>> fetchCategories() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulating a network call
    return categories;
  }

  Future<List<String>> fetchActivities(String category) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulating a network call
    return activities[category] ?? [];
  }

  Future<void> assignActivity(String email, String activity, String volunteer, String company) async {
    final response = await http.post(
      Uri.parse('$baseUrl/assign'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'activity': activity,
        'volunteer': volunteer,
        'company': company,
      }),
    );

    // Debugging: Print the response status and body
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode != 201) {
      throw Exception('Failed to assign activity: ${response.reasonPhrase}');
    }
  }

  void addVolunteer(String volunteer) {
    volunteers.add(volunteer);
  }

  void addCategory(String category) {
    categories.add(category);
    activities[category] = [];
  }

  void addActivity(String category, String activity) {
    if (activities.containsKey(category)) {
      activities[category]!.add(activity);
    }
  }
}
