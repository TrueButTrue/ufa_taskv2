// AuthService class for authentication
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ufa_task/models/users.dart';
import 'package:ufa_task/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Auth change user stream
  Stream<Users?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // Create user object based on FirebaseUser
  Users? _userFromFirebaseUser(User? user) {
    return user != null ? Users(uid: user.uid) : null;
  }

  // Sign in with email & password
  Future<Users?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (error) {
      print('Sign in error: $error');
      return null;
    }
  }

  // Register with email & password
  Future<Users?> registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      await DatabaseService(uid: user!.uid).updateUserData('New User', 'Volunteer', 'Category');

      return _userFromFirebaseUser(user);
    } catch (error) {
      print('Registration error: $error');
      return null;
    }
  }

  // Sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print('Sign out error: $error');
      return null;
    }
  }

  // Sign in anonymously
  Future<Users?> signInAnonymously() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (error) {
      print('Anonymous sign-in error: $error');
      return null;
    }
  }
}
