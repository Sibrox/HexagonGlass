import 'package:flutter/material.dart';
import 'package:hexagon_glass/widgets/planet_button.dart';

class PlanetListView extends StatefulWidget {
  const PlanetListView({Key? key}) : super(key: key);

  @override
  _PlanetListViewState createState() => _PlanetListViewState();
}

class _PlanetListViewState extends State<PlanetListView> {
  late List<AssetImage> planetImages;
  late List<String> planetString;
  late PageController _pageController;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: 0);

    planetImages = [];
    planetImages.add(const AssetImage('images/mozilla_planet.png'));
    planetImages.add(const AssetImage('images/ice_violet_planet.png'));
    planetImages.add(const AssetImage('images/dino_planet.png'));

    planetString = [];
    planetString.add("Mercuric");
    planetString.add("Jupiter");
    planetString.add("Saturn");
  }

  @override
  Widget build(BuildContext context) {

    return Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("images/stars_background.png"),
          fit: BoxFit.cover,
        )),
        child: Center(
          child: PageView.builder(
              itemCount: 3,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, position) {
                return Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Flexible(
                      //     child: TextButton(
                      //         onPressed: () {
                      //           if (currentIndex <= 0) return;
                      //           setState(() {
                      //             currentIndex--;
                      //           });
                      //           _pageController.animateToPage(currentIndex,
                      //               duration: const Duration(milliseconds: 300),
                      //               curve: Curves.easeIn);
                      //         },
                      //         child: const Text("Left"))),
                      Flexible(
                          child: Planet(
                              image: planetImages[position],
                              name: planetString[position])
                      ),
                      // Flexible(
                      //     child: TextButton(
                      //         onPressed: () {
                      //           if (currentIndex >= planetImages.length - 1) {
                      //             return;
                      //           }
                      //           setState(() {
                      //             currentIndex++;
                      //           });
                      //           _pageController.animateToPage(currentIndex,
                      //               duration: const Duration(milliseconds: 300),
                      //               curve: Curves.easeIn);
                      //         },
                      //         child: const Text("Right"))),
                    ],
                  ),
                );
              },
              controller: _pageController,),
        ));
  }
}
