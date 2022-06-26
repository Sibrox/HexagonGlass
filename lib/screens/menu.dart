import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexagon_glass/core/hexagon_core.dart';
import 'package:hexagon_glass/ui/hexagon_theme.dart';
import 'package:hexagon_glass/widgets/planet_list_view.dart';

import '../widgets/hexagon_grid.dart';

class Menu extends StatelessWidget {
  Menu({Key? key}) : super(key: key);

  final PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constrain) {
      return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF1D2530), Color(0xFF651283)])),
        child: Column(
          children: [
            Flexible(
                flex: 3,
                child: Row(
                  children: [
                    Flexible(child: Image.asset("images/arrow_left.png")),
                    Flexible(
                      flex: 9,
                      child: PageView.builder(
                        itemBuilder: (context, position) {
                          return Stack(children: [
                            Container(
                                margin: const EdgeInsets.only(
                                    top: 100, left: 20, right: 20),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    color: Colors.black.withOpacity(0.25)),
                                child: Grid(
                                  currentTheme: DinoTheme(),
                                  gameGrid: HexagonGame.create(4, 6),
                                )),
                            const Positioned(
                                top: 70,
                                left: 150,
                                child: DefaultTextStyle(
                                    style: TextStyle(
                                      fontSize: 40,
                                      fontFamily: 'Rowdies',
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    child: Text("Medium",
                                        textAlign: TextAlign.center))),
                            Padding(
                                padding: EdgeInsets.all(150),
                                child: Positioned(
                                  bottom: 1000,
                                  child: Planet(
                                      planet_path: "images/dino_planet.png"),
                                ))
                          ]);
                        },
                        controller: _controller,
                      ),
                    ),
                    Flexible(
                      child: GestureDetector(
                          onTap: () {
                            _controller.nextPage(
                                duration: Duration(milliseconds: 800),
                                curve: Curves.ease);
                          },
                          child: Image.asset("images/arrow_right.png")),
                    )
                  ],
                )),
            Flexible(
              flex: 1,
              child: Container(),
            )
          ],
        ),
      );
    });
  }
}

class Planet extends StatelessWidget {
  final String planet_path;
  const Planet({Key? key, required this.planet_path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Opacity(
          child: Image.asset(planet_path, color: Colors.black), opacity: 1.0),
      ClipRect(
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
              child: Image.asset(planet_path)))
    ]);
  }
}
