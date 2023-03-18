import 'package:flutter/material.dart';
import 'package:flutter_application_2/widget/user_widget.dart';

import 'model/user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'To jest moja apka'),
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
        title: Text(widget.title),
      ),
      body: Center(
        child: (Column(
          children: [
            UserWidget(user: User(name: "kotek", surname: "Mruszke")),
            UserWidget(user: User(name: "kotek", surname: "Mruszke")),
            UserWidget(user: User(name: "kotek", surname: "Mruszke")),
          ],
        )),
      ),
    );
  }
}
