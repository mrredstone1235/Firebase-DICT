import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CrudPage extends StatefulWidget {
  const CrudPage({super.key});

  @override
  State<CrudPage> createState() => _CrudPageState();
}

class _CrudPageState extends State<CrudPage> {
  List<Users> userList = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    getData(); // Fetch data when the widget is initialized
  }

  void getData() async {
    setState(() {
      _isLoading = true;
    });

    FirebaseFirestore.instance.collection('user').get().then((QuerySnapshot querySnapshot) {
      List<Users> users = [];
      querySnapshot.docs.forEach((doc) {
        String id = doc.id; // Document ID
        String name = doc['name']; // Access the name field
        Users user = Users(id: id, name: name);
        users.add(user);
      });

      setState(() {
        userList = users;
        _isLoading = false;
      });
    });
  }

  void deleteUser(int index) async {
    String userId = userList[index].id;

    // Delete document from Firestore
    await FirebaseFirestore.instance.collection('user').doc(userId).delete();

    // Remove item from userList
    setState(() {
      userList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase User List'),
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : userList.isEmpty
                ? Text('No users found.')
                : ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(userList[index].name),
                        subtitle: Text('ID: ${userList[index].id}'),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Delete ${userList[index].name}?'),
                                  content: Text('Are you sure you want to delete this user?'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('Cancel'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text('Delete'),
                                      onPressed: () {
                                        deleteUser(index);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}

class Users {
  final String id;
  final String name;

  Users({required this.id, required this.name});
}
