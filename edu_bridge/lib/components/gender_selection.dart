import 'package:flutter/material.dart';

class GenderSelectionWithController extends StatefulWidget {
  final TextEditingController genderController;

  // Constructor to accept a controller as an argument
  const GenderSelectionWithController(
      {Key? key, required this.genderController})
      : super(key: key);

  @override
  _GenderSelectionWithControllerState createState() =>
      _GenderSelectionWithControllerState();
}

class _GenderSelectionWithControllerState
    extends State<GenderSelectionWithController> {
  String? _selectedGender;

  @override
  void initState() {
    super.initState();
    // Initialize selected gender with the controller's current value or a default
    _selectedGender = widget.genderController.text.isNotEmpty
        ? widget.genderController.text
        : 'Male';
    widget.genderController.text =
        _selectedGender!; // Sync the controller with the initial selection
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gender',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            // Male Radio Button
            Radio<String>(
              value: 'Male',
              groupValue: _selectedGender,
              onChanged: (value) {
                setState(() {
                  _selectedGender = value;
                  widget.genderController.text =
                      value!; // Update controller text
                });
              },
            ),
            Text('Male'),

            // Female Radio Button
            Radio<String>(
              value: 'Female',
              groupValue: _selectedGender,
              onChanged: (value) {
                setState(() {
                  _selectedGender = value;
                  widget.genderController.text =
                      value!; // Update controller text
                });
              },
            ),
            Text('Female'),
          ],
        ),
      ],
    );
  }
}
