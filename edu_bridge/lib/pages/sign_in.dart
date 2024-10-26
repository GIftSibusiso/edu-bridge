import 'package:edu_bridge/auth/authentification.dart';
import 'package:edu_bridge/pages/create%20account.dart';
import 'package:edu_bridge/pages/home.dart';
import 'package:edu_bridge/pages/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
            const SizedBox(height: 18.0),
            const Text(
              'Empowering Minds,\nConnecting\nFutures.',
              style: TextStyle(
                fontSize: 20, // Adjust the size as needed for "huge" text
                color: Colors.black, // Text color black
                fontFamily: 'Kiwi Maru', // Font family Kiwi Maru
              ),
              textAlign: TextAlign.center, // Optional: Center align the text
            ),
            const SizedBox(height: 70.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                filled: true, // Enables background color
                fillColor: const Color(0xFFEEEEEE), // Background color #EEEEEE
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0), // Rounded corners
                  borderSide: const BorderSide(
                    color: Color(0xFF142B6F), // Border color #142B6F
                    width: 1.0, // Border thickness
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(30.0), // Keep rounded when focused
                  borderSide: const BorderSide(
                    color: Color(0xFF142B6F), // Border color #142B6F
                    width: 2, // Thicker border when focused
                  ),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                filled: true, // Enables background color
                fillColor: const Color(0xFFEEEEEE), // Background color #EEEEEE
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0), // Rounded corners
                  borderSide: const BorderSide(
                    color: Color(0xFF142B6F), // Border color #142B6F
                    width: 1.0, // Border thickness
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(30.0), // Keep rounded when focused
                  borderSide: const BorderSide(
                    color: Color(0xFF142B6F), // Border color #142B6F
                    width: 2, // Thicker border when focused
                  ),
                ),
              ),
              keyboardType: TextInputType.visiblePassword,
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width:
                  double.infinity, // Makes the button fill the available width
              child: ElevatedButton(
                onPressed: _loginUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFFFFD601), // Background color #FFD601
                  minimumSize: const Size(
                      double.infinity, 50), // Adjust height for a longer button
                ),
                child: const Text(
                  'Sign In',
                  style:
                      TextStyle(color: Color(0xFF142B6F)), // Text color #142B6F
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            TextButton(
              onPressed: () {
                Navigator.push(
                  // ignore: use_build_context_synchronously
                  context,
                  MaterialPageRoute(builder: (context) => ResetPasswordPage()),
                );
              },
              child: const Text('Forgot Password?'),
            ),
            const Divider(
              thickness: 1.0, // Thickness of the line
              color: Colors.grey, // Color of the line
              indent: 0, // Indentation from the left
              endIndent: 0, // Indentation from the right
            ),
            const SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  // ignore: use_build_context_synchronously
                  context,
                  MaterialPageRoute(builder: (context) => CreateAccountPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(0xFF142B6F), // Background color #FFD601
                minimumSize: const Size(
                    double.infinity, 50), // Adjust height for a longer button
              ),
              child: const Text(
                'Create a New Account',
                style: TextStyle(color: Colors.white), // Text color #142B6F
              ),
            ),
          ],
        ),
      ),
    );
  }
}
