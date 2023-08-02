import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_user_login/models/user.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  CurentUser? _userFromFirebaseAuth(FirebaseAuth user) {
    return user != null ? CurentUser(uid: user.currentUser!.uid) : null;
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> createWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> sendEmailVerify() async {
    currentUser!.sendEmailVerification();
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
