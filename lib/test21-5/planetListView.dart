import 'package:flutter/material.dart';

class Planet extends StatefulWidget {
  final AssetImage image;
  final bool isSelected;
  const Planet({Key? key, required this.image, required this.isSelected}) : super(key: key);

  @override
  _PlanetState createState() => _PlanetState();
}

class _PlanetState extends State<Planet> with TickerProviderStateMixin {

  late double width, bigWidth;
  late double height, bigHeight;

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 1400),
    vsync: this,
  );

  late bool isSelected;

  @override
  void initState() {

    super.initState();
    height = width = 200;
    bigHeight = bigWidth = width * 2;
    isSelected = widget.isSelected;
  }

  @override
  Wid 1get build(BuildContext context) {

    return LayoutBuilder(
        builder: (BuildContext contextText, BoxConstraints constraints) {
          final Size biggest = constraints.biggest;

          RelativeRect start = RelativeRect.fromSize(
              Rect.fromLTWH(biggest.width/2 - width/2, biggest.height/4 - height/2, width, height), biggest);
          RelativeRect end = RelativeRect.fromSize(
              Rect.fromLTWH(biggest.width/2 - bigWidth/2,
                  biggest.height/2 - bigWidth/2, bigWidth, bigWidth),
              biggest);

          return Stack(
            children: [
              AnimatedPositioned(
                top: isSelected? biggest.height/4 - height/2 : biggest.height/2 - bigWidth/2,
                left: isSelected? biggest.width/2 - bigWidth/2 : biggest.width/2 - width/2,
                width: isSelected? bigWidth : width,
                height: isSelected? bigHeight : height,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: widget.image,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                duration: Duration(milliseconds: 500),
                curve: Curves.bounceOut,
              ),
            ],
          );
        });
  }
}

class PlanetListView extends StatefulWidget {
  const PlanetListView({Key? key}) : super(key: key);

  @override
  _PlanetListViewState createState() => _PlanetListViewState();
}

class _PlanetListViewState extends State<PlanetListView> {
  late List<AssetImage> planetImages;

  late int currentIndex;
  late PageController _pageController;
  @override
  void initState() {
    super.initState();

    currentIndex = 0;
    _pageController = PageController(initialPage: 0);
    planetImages = [];
    planetImages.add(AssetImage('images/ArancioBlu.png'));
    planetImages.add(AssetImage('images/Avezzano.png'));
    planetImages.add(AssetImage('images/ZurroneII.png'));
  }

  @override
  Widget build(BuildContext context) {
    var planets = [];

    return Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("images/SuDario.png"),
          fit: BoxFit.fill,
        )),
        child: Center(
          child: PageView.builder(
              itemBuilder: (context, position) {
                return Center(
                  child: Row(

                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                          child: TextButton(
                              onPressed: () {
                                if (currentIndex <= 0) return;
                                setState(() {
                                  currentIndex--;
                                });
                                _pageController.animateToPage(currentIndex,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.easeIn);
                              },
                              child: Text("Left"))),
                      Flexible(child: Planet(image: planetImages[position], isSelected: position == currentIndex ? true : false)),
                      Flexible(
                          child: TextButton(
                              onPressed: () {
                                if (currentIndex >= planetImages.length - 1) return;
                                setState(() {
                                  currentIndex++;
                                });
                                _pageController.animateToPage(currentIndex,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.easeIn);
                              },
                              child: Text("Right"))),
                    ],
                  ),
                );
              },
              controller: _pageController),
        ));
  }
}
