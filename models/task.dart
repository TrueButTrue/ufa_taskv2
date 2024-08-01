class Task {
  final String id;
  final String title;
  final String description;
  final String dueDate;
  final String assignedVolunteer;
  final String status;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.assignedVolunteer,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate,
      'assignedVolunteer': assignedVolunteer,
      'status': status,
    };
  }

  static Task fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      dueDate: map['dueDate'],
      assignedVolunteer: map['assignedVolunteer'],
      status: map['status'],
    );
  }
}
