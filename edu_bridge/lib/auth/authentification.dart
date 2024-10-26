import 'package:firebase_auth/firebase_auth.dart';

Future<User?> createUser(String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  } on FirebaseAuthException catch (e) {
    print('Failed to create user: ${e.message}');
    return null;
  }
}

Future<User?> loginUser(String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    print("User logged in");
    return userCredential.user;
  } on FirebaseAuthException catch (e) {
    print('Failed to login: ${e.message}');
    return null;
  }
}

Future<bool> resetPassword(String email) async {
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    print('Password reset email sent');
    return true;
  } on FirebaseAuthException catch (e) {
    print('Failed to reset password: ${e.message}');
  }

  return false;
}

bool checkLoggedInUser() {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    print('User is logged in: ${user.email}');
    return true;
  } else {
    print('No user is logged in');
  }

  return false;
}

Future<void> logoutUser() async {
  try {
    await FirebaseAuth.instance.signOut();
    print('User logged out successfully');
  } catch (e) {
    print('Failed to log out: $e');
  }
}
