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
                        title: Text('Name: ${userList[index].name}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Age: ${userList[index].age}'),
                          ],
                        ),
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          navigateToCreateUserPage();
        },
      ),
    );
  }
}

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

class Users {
  final String id;
  final String name;
  final String age;

  Users({required this.id, required this.name, required this.age});
}
