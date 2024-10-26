import 'package:edu_bridge/auth/authentification.dart';
import 'package:edu_bridge/components/date_of_birth.dart';
import 'package:edu_bridge/components/gender_selection.dart';
import 'package:edu_bridge/components/subjects_dropdown.dart';
import 'package:edu_bridge/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateAccountPage extends StatefulWidget {
  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _subjectsController = TextEditingController();
  final TextEditingController _specialisationController =
      TextEditingController();
  final TextEditingController _schoolController =
      TextEditingController(); // Learner specific
  final TextEditingController _specializationController =
      TextEditingController(); // Mentor specific

  bool isLearner = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account'),
        automaticallyImplyLeading: true, // Enables the back button
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          // Wraps content in a scrollable view
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Toggle Buttons for Learner and Mentor
              ToggleButtons(
                isSelected: [isLearner, !isLearner],
                onPressed: (index) {
                  setState(() {
                    isLearner = index == 0;
                  });
                },
                borderRadius: BorderRadius.circular(8),
                selectedColor: Colors.white, // Text color when selected
                fillColor: Color(0xFF142B6F), // Background color when selected
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('Learner'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('Mentor'),
                  ),
                ],
              ),

              const SizedBox(height: 20.0),

              // Common Fields
              CommonFields(
                emailController: _emailController,
                fullNameController: _nameController,
                dobController: _dobController,
                genderController: _genderController,
                subjectsController: _subjectsController,
              ),

              // Role-specific Fields
              if (isLearner)
                LearnersFields(schoolController: _schoolController),
              if (!isLearner)
                MentorsFields(
                    specialisationController: _specialisationController),
              const SizedBox(height: 24.0),

              // Password
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  filled: true, // Enables background color
                  fillColor:
                      const Color(0xFFEEEEEE), // Background color #EEEEEE
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF142B6F), // Border color #142B6F
                      width: 1.0, // Border thickness
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        30.0), // Keep rounded when focused
                    borderSide: const BorderSide(
                      color: Color(0xFF142B6F), // Border color #142B6F
                      width: 2, // Thicker border when focused
                    ),
                  ),
                ),
                keyboardType: TextInputType.visiblePassword,
              ),

              const SizedBox(height: 24.0),

              // Submit Button
              SizedBox(
                width: double
                    .infinity, // Makes the button fill the available width
                child: ElevatedButton(
                  onPressed: _createAccount,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFFFFD601), // Background color #FFD601
                    minimumSize: const Size(double.infinity,
                        50), // Adjust height for a longer button
                  ),
                  child: const Text(
                    'Create account',
                    style: TextStyle(
                        color: Color(0xFF142B6F)), // Text color #142B6F
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method to handle account creation
  Future<void> _createAccount() async {
    // Capture form data and handle the account creation logic
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (isLearner) {
      final school = _schoolController.text.trim();
      print(
          'Creating Learner account: Name: $name, Email: $email, School: $school');
      // Implement learner-specific account creation
    } else {
      final specialization = _specializationController.text.trim();
      print(
          'Creating Mentor account: Name: $name, Email: $email, Specialization: $specialization');
      // Implement mentor-specific account creation
    }

    User? user = await createUser(email, password);

    if (user == null) {
      // Show error Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Failed creating account',
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
}

class CommonFields extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController fullNameController;
  final TextEditingController dobController;
  final TextEditingController genderController;
  final TextEditingController subjectsController;

  // Constructor to accept text as input
  const CommonFields(
      {super.key,
      required this.emailController,
      required this.fullNameController,
      required this.dobController,
      required this.genderController,
      required this.subjectsController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: fullNameController,
          decoration: InputDecoration(
            labelText: 'Full Name',
            filled: true, // Enables background color
            fillColor: const Color(0xFFEEEEEE), // Background color #EEEEEE
            enabledBorder: OutlineInputBorder(
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
          keyboardType: TextInputType.name,
        ),
        const SizedBox(height: 24.0),
        TextField(
          controller: emailController,
          decoration: InputDecoration(
            labelText: 'email',
            filled: true, // Enables background color
            fillColor: const Color(0xFFEEEEEE), // Background color #EEEEEE
            enabledBorder: OutlineInputBorder(
              // Rounded corners
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
        const SizedBox(height: 24.0),
        DateOfBirthInput(dobController: dobController),
        const SizedBox(height: 24.0),
        GenderSelectionWithController(genderController: genderController),
        const SizedBox(height: 24.0),
        MultiSelectDropdown(controller: subjectsController),
        const SizedBox(height: 24.0),
      ],
    );
  }
}

class LearnersFields extends StatelessWidget {
  final TextEditingController schoolController;

  // Constructor to accept text as input
  const LearnersFields({
    super.key,
    required this.schoolController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: schoolController,
          decoration: InputDecoration(
            labelText: 'School Name',
            filled: true, // Enables background color
            fillColor: const Color(0xFFEEEEEE), // Background color #EEEEEE
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
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
          keyboardType: TextInputType.name,
        ),
      ],
    );
  }
}

class MentorsFields extends StatelessWidget {
  final TextEditingController specialisationController;

  // Constructor to accept text as input
  const MentorsFields({
    super.key,
    required this.specialisationController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: specialisationController,
          decoration: InputDecoration(
            labelText: 'Specialization/Expertise',
            filled: true, // Enables background color
            fillColor: const Color(0xFFEEEEEE), // Background color #EEEEEE
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
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
          keyboardType: TextInputType.name,
        ),
      ],
    );
  }
}
