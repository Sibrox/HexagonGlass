import 'package:flutter/material.dart';
import 'package:hexagon_glass/screens/loading.dart';
import 'package:hexagon_glass/screens/menu.dart';
import 'package:flutter/services.dart';
import 'package:hexagon_glass/screens/tutorial.dart';

import 'package:hexagon_glass/ui/hexagon_theme.dart';
import 'package:permission_handler/permission_handler.dart';

import 'core/player_status.dart';
import 'core/save_folder.dart';

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
  bool loaded = false;
  bool tutorial = true; // TODO: read from status

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    loadResources();
  }

  void loadResources() async {
    var themes = await rootBundle.loadString('resources/themes.json');
    Themes().loadThemes(themes);

    var permission = await Permission.storage.request();
    if (permission.isGranted) {
      Map<String, dynamic> json = await SaveFolder.getSaveFile();
      Status.instance.loadStatus(json);
    } else {
      //TODO:handle the case: user deny storage permission.
    }

    setState(() {
      loaded = true;
      tutorial = Status.instance.getInfoJson()["player"]["tutorial"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return loaded
        ? Scaffold(
            body: tutorial
                ? Tutorial(
                    endTutorial: () {
                      setState(() {
                        tutorial = false;
                      });
                    },
                  )
                : const Menu())
        : const Scaffold(body: LoadingScreen());
  }
}

/**
child: Container(
color: Colors.blue,
child: const Center(child: Text('Tap me')),
),**/
