import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple UI',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Profile Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  // ignore: unused_field, prefer_final_fields
  int _counter = 0;
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SafeArea(
        child : Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            children: [
              Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12), 
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage('https://images.generated.photos/o0c1DwRBAy_jUcRn8Fgsl0Fn9-UdDaKv5WbAxuSu3Y0/rs:fit:512:512/wm:0.95:sowe:18:18:0.33/czM6Ly9pY29uczgu/Z3Bob3Rvcy1wcm9k/LnBob3Rvcy92M18w/NDY3MDk5LmpwZw.jpg')
                      ),
                    color: Colors.blue),
                  height: 72,
                  width: 72
                ),
                const SizedBox(width: 14),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [ 
                    Text('Tam Nguyen',
                    style: TextStyle(
                      fontWeight : FontWeight.bold,
                      fontSize: 18
                      )
                    ),
                    Text('Student', 
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14
                      ),
                    ),
                  ],
                )
              ],
            ),
            Container(
              color: Colors.black12,
              height: 1,
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromARGB(255, 142, 186, 245),
                  ),
                  height: 42,
                  width: 42,
                  child: const Icon(Icons.emoji_people, size: 30),
                ),
                const SizedBox(width:16,),
                const Expanded(child: Text('Personal Data')),
                const Icon(Icons.arrow_forward_ios, size: 16),
              ],
            ),
            Container(
              height: 1,
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromARGB(255, 142, 186, 245),
                  ),
                  height: 42,
                  width: 42,
                  child: const Icon(Icons.settings, size: 30),
                ),
                const SizedBox(width:16,),
                const Expanded(child: Text('Settings')),
                const Icon(Icons.arrow_forward_ios, size: 16),
              ],
            ),
            Container(
              height: 1,
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromARGB(255, 142, 186, 245),
                  ),
                  height: 42,
                  width: 42,
                  child: const Icon(Icons.library_books, size: 30),
                ),
                const SizedBox(width:16,),
                const Expanded(child: Text('E-statement')),
                const Icon(Icons.arrow_forward_ios, size: 16),
              ],
            ),
            Container(
              height: 1,
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromARGB(255, 142, 186, 245),
                  ),
                  height: 42,
                  width: 42,
                  child: const Icon(Icons.data_array, size: 30),
                ),
                const SizedBox(width:16,),
                const Expanded(child: Text('Referral Code')),
                const Icon(Icons.arrow_forward_ios, size: 16),
              ],
            ),
            Container(
              color: Colors.black12,
              height: 1,
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromARGB(255, 142, 186, 245),
                  ),
                  height: 42,
                  width: 42,
                  child: const Icon(Icons.quiz, size: 30),
                ),
                const SizedBox(width:16,),
                const Expanded(child: Text('FAQs')),
                const Icon(Icons.arrow_forward_ios, size: 16),
              ],
            ),
            Container(
              height: 1,
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromARGB(255, 142, 186, 245),
                  ),
                  height: 42,
                  width: 42,
                  child: const Icon(Icons.forum, size: 30),
                ),
                const SizedBox(width:16,),
                const Expanded(child: Text('Our Handbook')),
                const Icon(Icons.arrow_forward_ios, size: 16),
              ],
            ),
            Container(
              height: 1,
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromARGB(255, 142, 186, 245),
                  ),
                  height: 42,
                  width: 42,
                  child: const Icon(Icons.handshake, size: 30),
                ),
                const SizedBox(width:16,),
                const Expanded(child: Text('Community')),
                const Icon(Icons.arrow_forward_ios, size: 16),
              ],
            ),
            Container(
              height: 1,
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromARGB(255, 142, 186, 245)),
                    height: 100,
                    width: 585,      
                     child: const Row(
                    
                    children: [
                      SizedBox(width: 120),
                      Icon(Icons.headset_mic, size: 50),
                      SizedBox(width: 20),
                      Text('Feel Free to Ask, We Ready To Help',),      
                      ],
                    ),      
                  ),
                ],
              ),
              Container(
              height: 1,
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            ),
                const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.home, size:30),
                  Icon(Icons.chat, size:30),
                  Icon(Icons.mail, size:30),
                  Icon(Icons.person, size:30),

            ],
          ),

            ],
          )
      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    )
    );
  }
}