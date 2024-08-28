import 'package:flutter/material.dart';

class CustomContainer extends StatefulWidget {
  final String id;
  final String firstName;
  final String lastName;
  final String course;
  final String year;
  final bool enrolled;

  const CustomContainer({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.course,
    required this.year,
    required this.enrolled,
    required this.id,
  });

  @override
  State<CustomContainer> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.person, size: 30, color: Colors.blue),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              '${widget.firstName} ${widget.lastName}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const Icon(Icons.info, color: Colors.grey),
        ],
      ),
    );
  }
}
