import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_integration/screens/create_screen_page.dart';

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
        String name = doc['name'];
        String age = doc['age']; // Access the name field
        Users user = Users(id: id, name: name, age: age);
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

  void navigateToCreateUserPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateUserPage()),
    ).then((_) {
      // Refresh data after returning from Create User page
      getData();
    });
  }

  void navigateToEditUserPage(Users user) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => EditUserPage(user: user)),
  ).then((_) {
    // Refresh data after returning from Edit User page
    getData();
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('Firebase User List'),
title: const Text('Firebase User List'),
  actions: [
    Padding(padding: EdgeInsets.only(right: 20),child: IconButton(
      icon: const Icon(Icons.add),
      onPressed: () {
        navigateToCreateUserPage();
      },
      )),
  ],
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : userList.isEmpty
                ? Text('No users found.')
                : Scrollbar(child: 
                ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('Name: ${userList[index].name}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Age: ${userList[index].age}'),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                // Navigate to edit screen and pass user details
                                navigateToEditUserPage(userList[index]);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                // Show delete confirmation dialog
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
                          ],
                        ),
                      );
                    },
                  ),
                  )
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () {
      //     navigateToCreateUserPage();
      //   },
      // ),
    );
  }
}

class EditUserPage extends StatefulWidget {
  final Users user;

  EditUserPage({required this.user});

  @override
  _EditUserPageState createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.user.name;
    ageController.text = widget.user.age;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit User'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: ageController,
              decoration: InputDecoration(labelText: 'Age'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Update user details in Firestore
                updateUserData();
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

  void updateUserData() async {
    String newName = nameController.text;
    String newAge = ageController.text;

    // Update document in Firestore
    await FirebaseFirestore.instance.collection('user').doc(widget.user.id).update({
      'name': newName,
      'age': newAge,
    });

    // Navigate back to previous screen
    Navigator.pop(context);
  }
}



class Users {
  final String id;
  final String name;
  final String age;

  Users({required this.id, required this.name, required this.age});
}
