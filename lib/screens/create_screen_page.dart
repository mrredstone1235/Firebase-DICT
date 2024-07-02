import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CreateUserPage extends StatefulWidget {
  @override
  _CreateUserPageState createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  void createUser() async {
    String name = _nameController.text.trim();
    String age = _ageController.text.trim();

    // Add new user to Firestore
    await FirebaseFirestore.instance.collection('user').add({
      'name': name,
      'age' : age,
    });

    // Clear text field
    _nameController.clear();

    // Navigate back to previous screen
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _ageController,
              decoration: InputDecoration(
                labelText: 'Age',
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: createUser,
              child: Text('Create'),
            ),
          ],
        ),
      ),
    );
  }
}