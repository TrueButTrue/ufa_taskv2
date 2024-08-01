import 'package:flutter/material.dart';
import '../services/api_service.dart';

class ActivityAssignmentScreen extends StatefulWidget {
  const ActivityAssignmentScreen({super.key});

  @override
  _ActivityAssignmentScreenState createState() => _ActivityAssignmentScreenState();
}

class _ActivityAssignmentScreenState extends State<ActivityAssignmentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dueDateController = TextEditingController();
  final _emailController = TextEditingController();
  final _companyController = TextEditingController();
  String? _selectedVolunteer;
  String? _selectedCategory;
  String? _selectedActivity;
  final String _status = 'Pending';
  final ApiService apiService = ApiService(baseUrl: 'https://your-backend-api-url.com');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assign Activities'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              FutureBuilder<List<String>>(
                future: apiService.fetchVolunteers(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const CircularProgressIndicator();
                  return DropdownButtonFormField<String>(
                    value: _selectedVolunteer,
                    hint: const Text('Select Volunteer'),
                    items: snapshot.data!
                        .map((volunteer) => DropdownMenuItem(
                      value: volunteer,
                      child: Text(volunteer),
                    ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedVolunteer = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a volunteer';
                      }
                      return null;
                    },
                  );
                },
              ),
              FutureBuilder<List<String>>(
                future: apiService.fetchCategories(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const CircularProgressIndicator();
                  return DropdownButtonFormField<String>(
                    value: _selectedCategory,
                    hint: const Text('Select Category'),
                    items: snapshot.data!
                        .map((category) => DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value;
                        _selectedActivity = null;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a category';
                      }
                      return null;
                    },
                  );
                },
              ),
              FutureBuilder<List<String>>(
                future: _selectedCategory != null ? apiService.fetchActivities(_selectedCategory!) : null,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const CircularProgressIndicator();
                  return DropdownButtonFormField<String>(
                    value: _selectedActivity,
                    hint: const Text('Select Activity'),
                    items: snapshot.data!
                        .map((activity) => DropdownMenuItem(
                      value: activity,
                      child: Text(activity),
                    ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedActivity = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select an activity';
                      }
                      return null;
                    },
                  );
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _companyController,
                decoration: const InputDecoration(labelText: 'Company'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a company';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      await apiService.assignActivity(
                        _emailController.text,
                        _selectedActivity!,
                        _selectedVolunteer!,
                        _companyController.text,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Activity Assigned Successfully')),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Failed to assign activity')),
                      );
                    }
                  }
                },
                child: const Text('Assign Activity'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddDataScreen(apiService: apiService)),
                  );
                },
                child: const Text('Add Volunteers, Categories, Activities'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddDataScreen extends StatelessWidget {
  final ApiService apiService;
  final _volunteerController = TextEditingController();
  final _categoryController = TextEditingController();
  final _activityCategoryController = TextEditingController();
  final _activityController = TextEditingController();

  AddDataScreen({super.key, required this.apiService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _volunteerController,
              decoration: const InputDecoration(labelText: 'Volunteer Name'),
            ),
            ElevatedButton(
              onPressed: () {
                apiService.addVolunteer(_volunteerController.text);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Volunteer Added Successfully')),
                );
              },
              child: const Text('Add Volunteer'),
            ),
            TextField(
              controller: _categoryController,
              decoration: const InputDecoration(labelText: 'Category Name'),
            ),
            ElevatedButton(
              onPressed: () {
                apiService.addCategory(_categoryController.text);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Category Added Successfully')),
                );
              },
              child: const Text('Add Category'),
            ),
            TextField(
              controller: _activityCategoryController,
              decoration: const InputDecoration(labelText: 'Activity Category'),
            ),
            TextField(
              controller: _activityController,
              decoration: const InputDecoration(labelText: 'Activity Name'),
            ),
            ElevatedButton(
              onPressed: () {
                apiService.addActivity(_activityCategoryController.text, _activityController.text);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Activity Added Successfully')),
                );
              },
              child: const Text('Add Activity'),
            ),
          ],
        ),
      ),
    );
  }
}
