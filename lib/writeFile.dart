// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore: file_names
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WriteData extends StatefulWidget {
  static const String id = 'WriteData';
  @override
  _WriteDataState createState() => _WriteDataState();
}

class _WriteDataState extends State<WriteData> {
  final user = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        user
            .collection('user2')
            .add({'firstname': 'umer', 'lastname': 'Razzaq'});
      },
      child: Text('Click Me'),
    );
  }
}
