import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexagon_glass/core/game_logic.dart';
import 'package:hexagon_glass/screens/level.dart';
import 'package:hexagon_glass/ui/hexagon_theme.dart';
import 'package:hexagon_glass/ui/stroke_text.dart';

import '../widgets/game_grid.dart';
import 'menu.dart';

class Tutorial extends StatefulWidget {
  Function endTutorial;

  Tutorial({Key? key, required this.endTutorial}) : super(key: key);

  @override
  State<Tutorial> createState() => _TutorialState();
}

class _TutorialState extends State<Tutorial> {
  Map<String, dynamic> tutorial = {};
  int status = 0;

  late GameLogic tutorialLogic;
  @override
  void initState() {
    super.initState();
    loadTutorial();
  }

  void loadTutorial() async {
    var tutorialString = await rootBundle.loadString('resources/tutorial.json');


    setState(() {
      tutorial = jsonDecode(tutorialString);
      tutorialLogic = GameLogic.tutorial(tutorial["gameGrid"]);
    });
  }

  bool checkForNext([String? currentGame]) {
    //check if the condition is respected

    // Check end tutorial
    if (status == totalStatus() - 1) {
      widget.endTutorial();
    }

    var succeeded = false;
    if (tutorial["flow"][status]["interaction"] &&
        currentGame == tutorial["flow"][status]["condition"]) {
      setState(() {
        status = status + 1;
      });
      succeeded = true;
    } else if (!tutorial["flow"][status]["interaction"] &&
        status < totalStatus() - 1) {
      setState(() {
        status = status + 1;
      });
      succeeded = true;
    }
    return succeeded;
  }

  bool checkInteraction() {
    return tutorial["flow"][status]["interaction"];
  }

  int totalStatus() {
    return tutorial["flow"].length;
  }

  String getSentence() {
    return tutorial["flow"][status]["sentence"];
  }

  List<List<int>> getClickable() {
    List<List<int>> clickable = [];
    for (List<dynamic> point
        in tutorial["flow"][status + 2]["clickable"] ?? []) {
      clickable.add([point[0], point[1]]);
    }
    return clickable;
  }

  Widget NextArrow() {
    return checkInteraction()
        ? const SizedBox(
            width: 60,
            height: 60,
          )
        : Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: 43,
              height: 43,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/icons/arrow_right.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ));
  }

  Widget NextSentence() {
    String imagePath = tutorial["flow"][status]["image"] ?? "";

    return Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          Align(
              alignment: Alignment.topCenter,
              child: StrokeText(
                text: getSentence(),
                textAlign: TextAlign.center,
                fontSize: 20,
              )),
          imagePath.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(20),
                  child: Image.asset(
                    (imagePath),
                    fit: BoxFit.contain,
                  ))
              : Container(),
          NextArrow()
        ]));
  }

  Widget calculateTutorialInstruction() {
    return LayoutBuilder(
        builder: (BuildContext contextText, BoxConstraints constraints) {
      double maxHeight = constraints.heightConstraints().maxHeight;
      return AnimatedContainer(
          height: checkInteraction() ? (maxHeight * 0.21) : maxHeight,
          decoration: BoxDecoration(
              color: Colors.black.withAlpha(150),
              backgroundBlendMode: BlendMode.dstOut),
          duration: const Duration(
              milliseconds:
                  300), // This one will handle background + difference out
          child: NextSentence());
    });
  }

  void onTutorialClick(int i, int j) {
    tutorialLogic.status.changeColor(i, j);
    List<List<int>> clickable = getClickable();
    var condition =
      checkForNext(tutorialLogic.getGameGridStatus());

    if (condition) {
      tutorialLogic.setClickable(clickable);
    }
  }

  @override
  Widget build(BuildContext context) {

    return tutorial.isNotEmpty
        ? Stack(children: [

                Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Themes().planets[0].gradient_1,
                      Themes().planets[0].gradient_2,
                    ],
                  )),
                child: status < totalStatus() - 1 ? GameGrid(
                gameGrid: null,
                gameLogic: tutorialLogic,
                currentTheme: Themes().planets[0],
                onClick: onTutorialClick ): Container()),

            // This is the opaque container that contains instructions to follow
            GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  checkForNext();
                },
                child: calculateTutorialInstruction()),
          ])
        : Container();
  }
}
