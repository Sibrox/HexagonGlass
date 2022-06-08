import 'package:flutter/material.dart';
import 'package:hexagon_glass/core/hexagon_core.dart';
import 'package:hexagon_glass/widgets/hexagon_grid.dart';
import 'widgets/planet_list_view.dart';
import 'package:hexagon_glass/screens/menu.dart';

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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

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
  bool selected = false;

  HexagonGame game = HexagonGame.create(8, 8);

  double getBoxSize() {
    var deviceWidth = WidgetsBinding.instance.window.physicalSize.width;
    var marginPerc = 0.1;
    var marginSpace = deviceWidth * marginPerc;
    var hexagonBox = deviceWidth - marginSpace;
    var hexagonNumber = 8;
    var hexagonWidth = hexagonBox / hexagonNumber;

    return hexagonWidth;
  }

  @override
  Widget build(BuildContext context) {
    var hexagonGrid =
    Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment(1, 5),
              colors: [
                Color(0xFF070A4D),
                Color(0xFF4690C1),
              ],
            )
        ),
      child:
        Center(
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constrain) {
            return Grid(
                width: constrain.maxWidth,
                height: constrain.maxHeight,
                gameGrid: game);
          }),
      )
    );

    return const Scaffold(body: Menu());
  }
}

/**
child: Container(
color: Colors.blue,
child: const Center(child: Text('Tap me')),
),**/
