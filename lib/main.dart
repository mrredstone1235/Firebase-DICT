import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_integration/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

final GoogleSignIn googleSignIn = GoogleSignIn(
  clientId:
      '503343630355-0r6m8077rrmai249m5l8pi23bgf2r7i9.apps.googleusercontent.com',
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo sa DICT'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: ElevatedButton(onPressed: () async {
          final UserCredential? userCredential = await signInWithGoogle();
                if (userCredential != null) {
                  // Signed in
                  print('User: ${userCredential.user!.displayName}');
                  print('Sign in Successful');
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Logged in as: ${userCredential.user!.displayName}'),
                  ));
                } else {
                  // Sign in failed
                  print('Sign in failed');
                }
        }, child: const Text("Firebase")),
      ),
    );
  }
}

Future<UserCredential?> signInWithGoogle() async {
  try {
    // Trigger the Google Sign-In flow using the global instance
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    // Obtain the authentication details for the signed-in user.
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    // Create a new credential.
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Sign in to Firebase with the credential.
    return await FirebaseAuth.instance.signInWithCredential(credential);
  } catch (error) {
    // Handle sign-in errors.
    print("Error signing in with Google: $error");
    return null;
  }
}
