import 'package:flutter/material.dart';
import 'package:p2_individual_activity/models/student_model.dart';
import 'package:p2_individual_activity/services/api_service.dart';
import 'package:p2_individual_activity/widgets/custom_container.dart';
import 'package:p2_individual_activity/screens/student_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Student>> futureStudent;

  @override
  void initState() {
    super.initState();
    _refreshStudents();
  }

  Future<void> _refreshStudents() async {
    final apiService = ApiService();
    setState(() {
      futureStudent = apiService.getStudents();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 1,
        title: const Text(
          'Student List',
          style: TextStyle(
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
        actions: [
          Container(
            margin: const EdgeInsets.only(top: 10, right: 20),
            child: ElevatedButton.icon(
              onPressed: () async {
                final result =
                    await Navigator.pushNamed(context, '/studentForm');
                if (result == true) {
                  _refreshStudents();
                }
              },
              icon: const Icon(Icons.create),
              label: const Text('Add Student'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[700],
                foregroundColor: Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 20),
        child: RefreshIndicator(
          onRefresh: _refreshStudents,
          child: FutureBuilder<List<Student>>(
            future: futureStudent,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No Student Found'));
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    final student = snapshot.data![index];
                    return GestureDetector(
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                StudentDetails(student: student),
                          ),
                        );

                        if (result == true) {
                          _refreshStudents();
                        }
                      },
                      child: CustomContainer(
                        id: student.id,
                        firstName: student.firstName,
                        lastName: student.lastName,
                        course: student.course,
                        year: student.year!,
                        enrolled: student.enrolled,
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
