import 'package:flutter/material.dart';

class ErrorScreen extends StatefulWidget {
  final String title;

  const ErrorScreen({Key? key, required this.title}) : super(key: key);

  @override
  _ErrorScreenState createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return const Text(
      'Nav error',
      style: TextStyle(color: Colors.redAccent),
    );
  }
}
