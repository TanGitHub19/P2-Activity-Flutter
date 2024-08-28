import 'package:flutter/material.dart';
import 'package:p2_individual_activity/screens/home_screen.dart';
import 'package:p2_individual_activity/screens/student_form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Portal',
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        '/homeScreen': (context) => const HomeScreen(),
        '/studentForm': (context) => const StudentForm(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
