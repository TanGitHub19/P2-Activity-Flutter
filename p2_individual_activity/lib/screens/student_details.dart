import 'package:flutter/material.dart';
import 'package:p2_individual_activity/models/student_model.dart';
import 'package:p2_individual_activity/screens/update_student_form_screen.dart';

class StudentDetails extends StatefulWidget {
  final Student student;

  const StudentDetails({super.key, required this.student});

  @override
  State<StudentDetails> createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  Student? student;

  @override
  void initState() {
    super.initState();
    student = widget.student;
  }

  @override
  Widget build(BuildContext context) {
    if (student == null) {
      return const Scaffold(
        body: Center(child: Text('No Student Data Found')),
      );
    }

    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          elevation: 1,
          title: const Text(
            'Student\nDetails',
            style: TextStyle(
              fontSize: 28,
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
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 30, top: 10),
              child: ElevatedButton.icon(
                onPressed: () async {
                  final updatedStudent = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          UpdateStudentFormScreen(student: student!),
                    ),
                  );

                  if (updatedStudent != null) {
                    setState(() {
                      student = updatedStudent as Student;
                    });
                  }
                },
                icon: const Icon(Icons.update),
                label: const Text('Update'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[700],
                  foregroundColor: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
        ),
        body: Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: const EdgeInsets.only(top: 30),
            width: 350,
            height: 280,
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.person, color: Colors.blue),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'First Name: ${student!.firstName}',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.person_outline, color: Colors.blue),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Last Name: ${student!.lastName}',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Divider(color: Colors.grey.shade300),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.book, color: Colors.orange),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Course: ${student!.course}',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, color: Colors.green),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Year: ${student!.year}',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.check_circle, color: Colors.purple),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Enrolled: ${student!.enrolled ? 'Yes' : 'No'}',
                        style: TextStyle(
                          fontSize: 20,
                          color: student!.enrolled ? Colors.green : Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
