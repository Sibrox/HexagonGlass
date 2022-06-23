import 'package:flutter/material.dart';
import 'package:hexagon_glass/core/hexagon_core.dart';
import 'package:hexagon_glass/widgets/hexagon_grid.dart';
import 'widgets/planet_list_view.dart';
import 'package:hexagon_glass/screens/menu.dart';
import 'package:hexagon_glass/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
        fontFamily: 'Rowdies',
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool selected = false;

  HexagonGame game = HexagonGame.create(8, 8);

  @override
  Widget build(BuildContext context) {
    return Scaffold( body: HomePage());
  }
}

/**
child: Container(
color: Colors.blue,
child: const Center(child: Text('Tap me')),
),**/
