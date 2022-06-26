import 'package:flutter/material.dart';
import 'package:hexagon_glass/screens/level.dart';
import 'package:hexagon_glass/screens/menu.dart';
import 'package:hexagon_glass/ui/hexagon_theme.dart';
import 'package:hexagon_glass/widgets/planet_list_view.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Color(0xFF3A3734),
            Color(0xFFC0C0C0),
          ])),
      child: Center(
          child: Column(
        children: [
          Flexible(flex: 2, child: Container()),
          Flexible(
              child: Center(
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Menu()));
                },
                child: const Center(
                  child: RouteButton(buttonTitle: "Story"),
                )),
          )),
          Flexible(
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Level(
                                currentTheme: MozillaTheme(),
                              )));
                },
                child: const Center(
                  child: RouteButton(buttonTitle: "Infinity"),
                )),
          ),
          Flexible(
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Level(
                                currentTheme: DinoTheme(),
                              )));
                },
                child: const Center(
                  child: RouteButton(buttonTitle: "Infinity"),
                )),
          ),
          Flexible(
            flex: 3,
            child: Container(),
          ),
        ],
      )),
    );
  }
}

class RouteButton extends StatelessWidget {
  final String buttonTitle;
  const RouteButton({Key? key, required this.buttonTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Padding(
          padding: const EdgeInsets.all(0),
          child: Container(
            margin: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
            decoration: const BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.all(Radius.circular(20))),
          )),
      Center(
        child: DefaultTextStyle(
            style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: "Rowdies"),
            child: Text(buttonTitle)),
      )
    ]);
  }
}
