import 'package:flutter/material.dart';
import 'package:p2_individual_activity/models/student_model.dart';
import 'package:p2_individual_activity/services/api_service.dart';

class StudentForm extends StatefulWidget {
  const StudentForm({super.key});

  @override
  State<StudentForm> createState() => _StudentFormState();
}

class _StudentFormState extends State<StudentForm> {
  bool isEnrolled = false;
  String? selectedYear;

  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _course = TextEditingController();

  final List<String> year = [
    'First Year',
    'Second Year',
    'Third Year',
    'Fourth Year',
    'Fifth Year'
  ];

  final ApiService _apiService = ApiService();

  void toggleSwitch(bool value) {
    setState(() {
      isEnrolled = value;
    });
  }

  void _submitForm() async {
    final student = Student(
      id: DateTime.now().toIso8601String(),
      firstName: _firstName.text,
      lastName: _lastName.text,
      course: _course.text,
      year: selectedYear,
      enrolled: isEnrolled,
    );

    await _apiService.createStudent(student);
    _firstName.clear();
    _lastName.clear();
    _course.clear();
    setState(() {
      selectedYear = null;
      isEnrolled = false;
    });
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Student Form', style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
            letterSpacing: 1.5,
            shadows: [
              Shadow(
                offset: Offset(0, 2),
                blurRadius: 3,
                color: Colors.grey,
              ),
            ],
            decorationColor: Colors.blue,
            decorationThickness: 1.5,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
            border: Border.all(width: 1, color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.only(right: 20, left: 20, top: 30),
            child: Column(children: [
              const Text(
                'Fill Up Form',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  letterSpacing: 1.5,
                  shadows: [
                    Shadow(
                      offset: Offset(0, 2),
                      blurRadius: 3,
                      color: Colors.grey,
                    ),
                  ],
                  decorationColor: Colors.blue,
                  decorationThickness: 1.5,
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _firstName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelText: 'First Name',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _lastName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelText: 'Last Name',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _course,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelText: 'Course',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelText: 'Year',
                ),
                value: selectedYear,
                hint: const Text('Select Year'),
                onChanged: (value) {
                  setState(() {
                    selectedYear = value;
                  });
                },
                items: year.map((String year) {
                  return DropdownMenuItem<String>(
                    value: year,
                    child: Text(year),
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 10,
              ),
              SwitchListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                title: Text(
                  'Enrolled',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.blueGrey[800],
                  ),
                ),
                subtitle: Text(
                  isEnrolled ? 'Yes' : 'No',
                  style: TextStyle(
                    fontSize: 16,
                    color: isEnrolled ? Colors.green : Colors.red,
                  ),
                ),
                value: isEnrolled,
                activeColor: Colors.blue,
                activeTrackColor: Colors.blueAccent.withOpacity(0.3),
                inactiveThumbColor: Colors.grey,
                inactiveTrackColor: Colors.grey.withOpacity(0.3),
                onChanged: (bool value) {
                  setState(() {
                    isEnrolled = value;
                  });
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 110),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    shadowColor: Colors.blueAccent,
                    elevation: 5,
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  onPressed: _submitForm,
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
