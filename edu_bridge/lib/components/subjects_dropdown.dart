import 'package:flutter/material.dart';

class MultiSelectDropdown extends StatefulWidget {
  final TextEditingController controller;

  const MultiSelectDropdown({Key? key, required this.controller})
      : super(key: key);

  @override
  _MultiSelectDropdownState createState() => _MultiSelectDropdownState();
}

class _MultiSelectDropdownState extends State<MultiSelectDropdown> {
  final List<String> _subjects = [
    'Mathematics',
    'Mathematical Literacy',
    'Physical Sciences',
    'Life Sciences',
    'Agricultural Sciences',
    'Accounting',
    'Business Studies',
    'Economics',
    'Geography',
    'History',
    'Religious Studies',
    'Information Technology',
    'Computer Applications Technology',
    'Engineering Graphics and Design',
    'Visual Arts',
    'Dramatic Arts',
    'Music',
    'Dance Studies',
    'Design',
    'French',
    'German',
    'Portuguese',
    'Mandarin',
    'Spanish',
    'Tourism',
    'Hospitality Studies',
    'Consumer Studies',
    'Agricultural Management Practices',
    'Agricultural Technology',
    'Electrical Technology',
    'Mechanical Technology',
    'Civil Technology',
  ];

  List<String> _selectedSubjects = []; // List to store selected subjects

  void _openMultiSelectDialog() async {
    final List<String>? selectedSubjects = await showDialog<List<String>>(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(
          subjects: _subjects,
          selectedSubjects: _selectedSubjects,
        );
      },
    );

    if (selectedSubjects != null) {
      setState(() {
        _selectedSubjects = selectedSubjects;
        widget.controller.text = _selectedSubjects.join(', ');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Subjects',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          onTap: _openMultiSelectDialog,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              widget.controller.text.isNotEmpty
                  ? widget.controller.text
                  : 'Select your subjects',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}

class MultiSelectDialog extends StatefulWidget {
  final List<String> subjects;
  final List<String> selectedSubjects;

  const MultiSelectDialog({
    Key? key,
    required this.subjects,
    required this.selectedSubjects,
  }) : super(key: key);

  @override
  _MultiSelectDialogState createState() => _MultiSelectDialogState();
}

class _MultiSelectDialogState extends State<MultiSelectDialog> {
  late List<String> _tempSelectedSubjects;

  @override
  void initState() {
    super.initState();
    _tempSelectedSubjects = List.from(widget.selectedSubjects);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Subjects'),
      content: SingleChildScrollView(
        child: Column(
          children: widget.subjects.map((subject) {
            return CheckboxListTile(
              title: Text(subject),
              value: _tempSelectedSubjects.contains(subject),
              onChanged: (bool? value) {
                setState(() {
                  if (value == true) {
                    _tempSelectedSubjects.add(subject);
                  } else {
                    _tempSelectedSubjects.remove(subject);
                  }
                });
              },
            );
          }).toList(),
        ),
      ),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.of(context).pop(_tempSelectedSubjects);
          },
        ),
      ],
    );
  }
}
