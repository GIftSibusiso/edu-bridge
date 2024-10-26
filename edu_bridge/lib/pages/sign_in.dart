import 'package:edu_bridge/auth/authentification.dart';
import 'package:edu_bridge/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Function to sign in the user
  Future<void> _loginUser() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    User? user = await loginUser(email, password);

    if (user == null) {
      // Show error Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Login failed: Invalid email or password',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color.fromRGBO(20, 43, 111, 1),
          duration: Duration(seconds: 3),
        ),
      );
    } else {
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
            builder: (context) => const MyHomePage(
                  "Home Page",
                  title: 'Home',
                )),
      );
    }
  }

  // Function to show error dialogs
  void _showErrorDialog(String? message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message ?? 'Unknown error occurred'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Function to reset password
  Future<void> _resetPassword() async {
    String email = _emailController.text.trim();

    try {
      await _auth.sendPasswordResetEmail(email: email);
      print('Password reset email sent');
      _showInfoDialog('Password reset email has been sent to $email.');
    } on FirebaseAuthException catch (e) {
      print('Failed to reset password: ${e.message}');
      _showErrorDialog(e.message);
    }
  }

  // Function to show info dialogs
  void _showInfoDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Info'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'EDU-CONNECT',
              style: TextStyle(
                fontSize: 32.0, // Adjust size as needed for "huge" text
                color: Color(0xFF142B6F), // Text color #142B6F
                fontFamily: 'Roboto', // Font family Roboto
                fontWeight: FontWeight.bold, // Optional: Makes the text bold
              ),
            ),
            SizedBox(height: 18.0),
            const Text(
              'Empowering Minds,\nConnecting\nFutures.',
              style: TextStyle(
                fontSize: 20, // Adjust the size as needed for "huge" text
                color: Colors.black, // Text color black
                fontFamily: 'Kiwi Maru', // Font family Kiwi Maru
              ),
              textAlign: TextAlign.center, // Optional: Center align the text
            ),
            SizedBox(height: 70.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                filled: true, // Enables background color
                fillColor: Color(0xFFEEEEEE), // Background color #EEEEEE
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0), // Rounded corners
                  borderSide: BorderSide(
                    color: Color(0xFF142B6F), // Border color #142B6F
                    width: 2.0, // Border thickness
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(30.0), // Keep rounded when focused
                  borderSide: BorderSide(
                    color: Color(0xFF142B6F), // Border color #142B6F
                    width: 2.5, // Thicker border when focused
                  ),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                filled: true, // Enables background color
                fillColor: Color(0xFFEEEEEE), // Background color #EEEEEE
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0), // Rounded corners
                  borderSide: BorderSide(
                    color: Color(0xFF142B6F), // Border color #142B6F
                    width: 2.0, // Border thickness
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(30.0), // Keep rounded when focused
                  borderSide: BorderSide(
                    color: Color(0xFF142B6F), // Border color #142B6F
                    width: 2.5, // Thicker border when focused
                  ),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16.0),
            SizedBox(
              width:
                  double.infinity, // Makes the button fill the available width
              child: ElevatedButton(
                onPressed: _loginUser,
                child: Text(
                  'Sign In',
                  style:
                      TextStyle(color: Color(0xFF142B6F)), // Text color #142B6F
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Color(0xFFFFD601), // Background color #FFD601
                  minimumSize: Size(
                      double.infinity, 50), // Adjust height for a longer button
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            TextButton(
              onPressed: _resetPassword,
              child: Text('Forgot Password?'),
            ),
            const Divider(
              thickness: 1.0, // Thickness of the line
              color: Colors.grey, // Color of the line
              indent: 0, // Indentation from the left
              endIndent: 0, // Indentation from the right
            ),
            SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                'Create a New Account',
                style: TextStyle(color: Colors.white), // Text color #142B6F
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF142B6F), // Background color #FFD601
                minimumSize: Size(
                    double.infinity, 50), // Adjust height for a longer button
              ),
            ),
          ],
        ),
      ),
    );
  }
}
