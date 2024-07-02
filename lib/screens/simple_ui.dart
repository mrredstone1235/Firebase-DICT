import 'package:flutter/material.dart';

class SimpleUi extends StatefulWidget {
  const SimpleUi({super.key});

  @override
  State<SimpleUi> createState() => _SimpleUiState();
}

class _SimpleUiState extends State<SimpleUi> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: MaterialApp(
        title: 'Justine Favia', // Title of the Tab
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Color.fromARGB(255, 9, 158, 238)), // change color
        ),
        home:
            const MyHomePage(title: 'Page Title Display'), // page title display
      ),
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
      body: Column(
        children: [
          Row(
            children: [
              Container(
                  // color: Colors.red,
                  width: 64,
                  height: 64,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://scontent.fmnl13-1.fna.fbcdn.net/v/t1.6435-9/36449944_652109758462827_3229251537515577344_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=1d70fc&_nc_ohc=5fqfCl5oRS0Q7kNvgEyXAtk&_nc_ht=scontent.fmnl13-1.fna&oh=00_AYD6fEPRcoKv_JWXmHPpAuACh_mLzpHdLNkkcUQV38YnMw&oe=66A340F9'))),
                  margin: const EdgeInsets.only(left: 12, top: 12)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Container(
                  //   color: Colors.orange,
                  //     width: 180,
                  //     height: 14,
                  //     margin: const EdgeInsets.only(left: 12, top: 12)),
                  Container(
                    margin: const EdgeInsets.only(left: 10, top: 5),
                    child: const Text('John Mark Bermudez'),
                  ),
                  // Container(
                  //     color: Colors.orange,
                  //     width: 180,
                  //     height: 14,
                  //     margin: const EdgeInsets.only(left: 12, top: 12)),
                  Container(
                    margin: const EdgeInsets.only(left: 10, top: 5),
                    child: const Text(
                      'johnmarkbermudez0702@gmail.com',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          const Divider(
            height: 1,
          ),
          for (var i = 0; i < 5; i++) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      color: Colors.red,
                      width: 52,
                      height: 52,
                      margin: const EdgeInsets.only(left: 12, top: 12),
                    ),
                    Container(
                        color: Colors.blue,
                        width: 250,
                        height: 18,
                        margin: const EdgeInsets.only(left: 12, top: 12)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                            // color: Colors.yellow,
                            // width: 18,
                            // height: 18,
                            margin: const EdgeInsets.only(
                              left: 12,
                              top: 12,
                              right: 12,
                            ),
                            // color: Colors.yellow,
                            // width: 18,
                            // height: 18,
                            child: Icon(Icons.arrow_forward_ios)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
          const SizedBox(
            height: 12,
          ),
          const Divider(
            height: 1,
          ),
          Container(
              color: Colors.blue,
              width: 700,
              height: 100,
              margin: const EdgeInsets.only(
                left: 50,
                top: 50,
                right: 50,
                bottom: 50,
              )),
        ],
      ),
    );
  }
}
