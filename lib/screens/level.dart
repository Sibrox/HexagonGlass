import 'package:flutter/material.dart';

import '../core/hexagon_core.dart';
import '../widgets/hexagon_grid.dart';

class Level extends StatelessWidget {
  Level({Key? key}) : super(key: key);

  HexagonGame hexagonGrid = HexagonGame.create(6,10);
  var level = "PRova";
  // 070A4D
  // 4690C1
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF4E8CAD),
              Color(0xFF2D3F8A),
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
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20),),
                  image: const DecorationImage(
                      image: AssetImage("images/dino_background.jpg"),
                      fit: BoxFit.cover
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black87.withOpacity(0.6),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
              )
          ),
          Flexible(
              flex: 8,
              child: Grid(gameGrid: hexagonGrid)
          ),
          Flexible(
            flex: 1,
              child: Center(
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child:  Image.asset(
                        ("images/dino_planet.png"),
                        fit: BoxFit.contain,

                      ),
                    ),
                    const DefaultTextStyle( style: TextStyle(fontSize: 20, fontFamily: 'Rowdies', color: Colors.white),child: Text( "5 / 10"))
                  ],
                ),
              )
          )
        ],
      )
    );
  }
}
