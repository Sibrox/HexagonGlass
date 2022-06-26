import 'package:flutter/material.dart';
import 'package:hexagon_glass/ui/hexagon_theme.dart';

import '../core/hexagon_core.dart';
import '../widgets/hexagon_grid.dart';

class Level extends StatelessWidget {
  HexagonTheme currentTheme;
  Level({Key? key, required this.currentTheme }) : super(key: key);

  HexagonGame hexagonGrid = HexagonGame.create(6,10);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              currentTheme.gradient_1,
              currentTheme.gradient_2,
            ],
          )
      ),
      child:       Column(
        children: [
          Flexible(
              flex: 2,
              child:
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  image:  DecorationImage(
                      image: AssetImage(currentTheme.background_path),
                      fit: BoxFit.cover
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black87.withOpacity(0.6),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
              )
          ),
          Flexible(
              flex: 8,
              child: Grid(gameGrid: hexagonGrid, currentTheme: currentTheme,)
          ),
          Flexible(
            flex: 1,
            child: Center(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: () {Navigator.pop(context);},
                      child: Image.asset(
                        (currentTheme.planet_path),
                        fit: BoxFit.contain,
                      ),
                    )
                  ),
                  const DefaultTextStyle(
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Rowdies',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                      ),
                      child: Text( "5 / 10")),
                  Flexible(child: Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      child:
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Image.asset("images/refresh_icon.png"),
                        )
                      ),
                    )
                  )
                ],
              ),
            )
          )
        ],
      )
    );
  }
}
