import 'package:flutter/material.dart';
import 'package:hexagon_glass/ui/hexagon_theme.dart';
import 'package:hexagon_glass/widgets/page_menu.dart';
import 'package:hexagon_glass/core/save_folder.dart';
import 'package:permission_handler/permission_handler.dart';

import '../core/player_status.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final PageController _controller = PageController(
    initialPage: 0,
  );

  late int position;

  bool loadedThemes = false;

  @override
  void initState() {
    super.initState();
    position = 0;
    loadThemes();
  }

  void loadThemes() async {
    var permission = await Permission.storage.request();
    if (permission.isGranted) {
      Map<String, dynamic> json = await SaveFolder.getSaveFile();
      Status.instance.loadStatus(json);
    } else {
      //TODO:handle the case: user deny storage permission.
    }

    setState(() {
      loadedThemes = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var menuPage = LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constrain) {
      return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Themes.instance.getTheme(position).gradient_1,
              Themes.instance.getTheme(position).gradient_2
            ])),
        child: Column(
          children: [
            Flexible(
                flex: 3,
                child: Row(
                  children: [
                    Flexible(
                      flex: 9,
                      child: PageView.builder(
                        itemCount: Themes.instance.planets.length,
                        onPageChanged: (page) {
                          setState(() {
                            position = page;
                          });
                        },
                        itemBuilder: (context, position) {
                          return PageMenu(
                            currentTheme: Themes.instance.getTheme(position),
                          );
                        },
                        controller: _controller,
                      ),
                    ),
                  ],
                )),
          ],
        ),
      );
    });
    return loadedThemes ? menuPage : const CircularProgressIndicator();
  }
}
