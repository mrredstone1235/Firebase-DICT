import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Second Screen'),
      //   // Add a leading button to the AppBar
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back),
      //     onPressed: () {
      //       // Navigate back to the previous screen
      //       Navigator.pop(context);
      //     },
      //   ),
      // ),
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
                    ElevatedButton(onPressed: (){
                      signOut();
                      Navigator.pop(context);
                    }, child: Text("Log out"))
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

Future<void> signOut() async {
  await FirebaseAuth.instance.signOut();
}
