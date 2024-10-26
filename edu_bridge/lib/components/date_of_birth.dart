import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For formatting the date

class DateOfBirthInput extends StatefulWidget {
  final TextEditingController dobController;

  // Constructor to accept dobController as an argument
  const DateOfBirthInput({Key? key, required this.dobController})
      : super(key: key);

  @override
  _DateOfBirthInputState createState() => _DateOfBirthInputState();
}

class _DateOfBirthInputState extends State<DateOfBirthInput> {
  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Set initial date
      firstDate: DateTime(1900), // Set the earliest date you allow
      lastDate: DateTime.now(), // Set the latest date to today
    );

    if (picked != null) {
      setState(() {
        widget.dobController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.dobController,
      decoration: InputDecoration(
        labelText: 'Date of Birth',
        filled: true, // Enables background color
        fillColor: const Color(0xFFEEEEEE), // Background color #EEEEEE
        suffixIcon: const Icon(Icons.calendar_today),
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
            width: 2.0, // Thicker border when focused
          ),
        ),
      ),
      readOnly: true, // Prevents manual input
      onTap: () => _selectDate(context),
    );
  }
}
