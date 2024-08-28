import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:p2_individual_activity/models/student_model.dart';

const String apiUrl = 'https://p2-individual-activity.vercel.app/api/student/';

class ApiService {
  Future<List<Student>> getStudents() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => Student.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load students: ${response.reasonPhrase}');
    }
  }

  Future<Student?> getStudent(String id) async {
    final response = await http.get(Uri.parse('$apiUrl$id'));
    if (response.statusCode == 200) {
      return Student.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      return null;
    }
  }

  Future<Student> createStudent(Student student) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(student.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Student.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      final statusCode = response.statusCode;
      final responseBody = response.body;
      throw Exception(
          'Failed to create student. Status code: $statusCode, Response: $responseBody');
    }
  }

  Future<Student> updateStudent(Student student) async {
    final response = await http.put(
      Uri.parse('$apiUrl${student.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(student.toJson()),
    );

    if (response.statusCode == 200) {
      return Student.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception(
          'Failed to update student. Status code: ${response.statusCode}, Response: ${response.body}');
    }
  }

  Future<void> deleteStudent(String id) async {
    final response = await http.delete(
      Uri.parse('$apiUrl$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete student: ${response.reasonPhrase}');
    }
  }
}
