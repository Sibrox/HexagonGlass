import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexagon_glass/core/hexagon_core.dart';
import 'package:hexagon_glass/ui/hexagon_theme.dart';
import 'package:hexagon_glass/widgets/page_menu.dart';
import 'package:hexagon_glass/widgets/planet_list_view.dart';

import '../widgets/hexagon_grid.dart';

class Menu extends StatefulWidget {
  Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final PageController _controller = PageController(
    initialPage: 0,
  );

  late var position;

  @override
  void initState() {
    position = 0;
  }

  HexagonTheme getTheme(int? page) {
    switch (page) {
      case 0:
        return MozillaTheme();
      case 1:
        return DinoTheme();
    }

    return MozillaTheme();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constrain) {
      return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              getTheme(position).gradient_1,
              getTheme(position).gradient_2
            ])),
        child: Column(
          children: [
            Flexible(
                flex: 3,
                child: Row(
                  children: [
                    // Flexible(
                    //     child: GestureDetector(
                    //       onTap: () {
                    //         _controller.previousPage(
                    //         duration: const Duration(milliseconds: 800),
                    //         curve: Curves.ease);
                    //       },
                    //       child: Image.asset("images/arrow_left.png")),
                    // ),
                    Flexible(
                      flex: 9,
                      child: PageView.builder(
                        itemCount: 2,
                        onPageChanged: (page) {
                          setState(() {
                            position = page;
                          });
                        },
                        itemBuilder: (context, position) {
                          return PageMenu(currentTheme: getTheme(position));
                        },
                        controller: _controller,
                      ),
                    ),
                    // Flexible(
                    //   child: GestureDetector(
                    //       onTap: () {
                    //         _controller.nextPage(
                    //             duration: const Duration(milliseconds: 800),
                    //             curve: Curves.ease);
                    //       },
                    //       child: Image.asset("images/arrow_right.png")),
                    // )
                  ],
                )),
          ],
        ),
      );
    });
  }
}
