import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  final CollectionReference volunteerCollection = FirebaseFirestore.instance.collection('volunteers');

  Future<void> updateUserData(String name, String role, String category) async {
    return await volunteerCollection.doc(uid).set({
      'name': name,
      'role': role,
      'category': category,
      'email': FirebaseAuth.instance.currentUser?.email ?? '',
    });
  }

  Stream<List<Volunteer>> get volunteers {
    return volunteerCollection.snapshots().map(_volunteersFromSnapshot);
  }

  List<Volunteer> _volunteersFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Volunteer(
        name: doc['name'] ?? '',
        role: doc['role'] ?? '',
        category: doc['category'] ?? '',
      );
    }).toList();
  }
}

class Volunteer {
  final String name;
  final String role;
  final String category;

  Volunteer({required this.name, required this.role, required this.category});
}
