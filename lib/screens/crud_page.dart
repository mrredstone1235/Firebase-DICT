import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CrudPage extends StatelessWidget {
  const CrudPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: ElevatedButton(onPressed: (){getData();}, child: Text("button")),),);
  }
}


// Example function to retrieve documents from Firestore
void getData() {
  FirebaseFirestore.instance
      .collection('user')
      .get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      print(doc.id); // Document ID
      print(doc['name']); // Example field access
      print(doc['age']); // Example field access
    });
  });
}