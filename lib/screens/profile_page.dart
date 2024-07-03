import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_integration/main.dart';
import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override

  bool _loggingOut = false;

    void _logout() async {
    setState(() {
      _loggingOut = true;
    });

    try {
      await FirebaseAuth.instance.signOut();
      // Navigate to the login screen or another appropriate screen after logout
      Navigator.pop(context); // Example: Navigate back to previous screen
    } catch (e) {
      print('Error logging out: $e');
      // Handle error (show snackbar, display error message, etc.)
    } finally {
      setState(() {
        _loggingOut = false;
      });
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
        // Add a leading button to the AppBar
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to the previous screen
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: FutureBuilder(
          future: FirebaseAuth.instance.authStateChanges().first,
          builder: (context, AsyncSnapshot<User?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else {
              if (snapshot.hasData && snapshot.data != null) {
                User? user = snapshot.data;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ClipOval(child:
                    Image.network(
                        user!.photoURL!,
                        fit: BoxFit.fitHeight,
                      ),),
                    
                    SizedBox(height: 20),
                    Text(
                      user!.displayName ?? 'No Display Name',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      user.email ?? 'No Email',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    ElevatedButton(onPressed: _loggingOut ? null : _logout,
                     child: _loggingOut
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                strokeWidth: 3,
                              ),
                            )
                          : const Text("Log out"),)
                  ],
                );
              } else {
                return Text('No user logged in');
              }
            }
          },
        ),
      ),
    );
  }
}
