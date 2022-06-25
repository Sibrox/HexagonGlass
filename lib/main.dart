import 'package:flutter/material.dart';
import 'package:hexagon_glass/core/hexagon_core.dart';
import 'package:hexagon_glass/screens/level.dart';
import 'package:hexagon_glass/widgets/hexagon_grid.dart';
import 'widgets/planet_list_view.dart';
import 'package:hexagon_glass/screens/menu.dart';
import 'package:hexagon_glass/screens/home.dart';
import 'package:flutter/services.dart';

import 'dart:async' show Future;

Future<String> loadAsset() async {
  String toParse = await rootBundle.loadString('resources/level_1.txt');
  List<List<String>> game = [[]];
  List<String> rows = toParse.split("\n");
  for (var row in rows) {
    game.add(row.split(" "));
  }

  for(int i = 0; i < game.length; i++) {
    for(int j = 0; j < game[i].length; j++) {
      (game[i][j]);
    }
  }

  return toParse;
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
  //This line is used for showing the bottom bar
  ]);
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
  void dispose() {
    super.dispose();

  }

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
