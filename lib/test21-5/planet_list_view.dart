import 'package:flutter/material.dart';

class Planet extends StatefulWidget {
  final String name;
  final AssetImage image;

  const Planet({Key? key, required this.name, required this.image})
      : super(key: key);

  @override
  _PlanetState createState() => _PlanetState();
}

class _PlanetState extends State<Planet> with TickerProviderStateMixin {

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 800),
    vsync: this,
  );

  late final AnimationController _controller2 = AnimationController(
    duration: const Duration(milliseconds: 800),
    vsync: this,
  );

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    _controller2.forward();

    return LayoutBuilder(
        builder: (BuildContext contextText, BoxConstraints constraints) {
            final Size biggest = constraints.biggest;

            var width = biggest.width / 4;
            var height = biggest.width / 2;
            var bigWidth = width * 2;
            var bigHeight = height * 2;

            RelativeRect start = RelativeRect.fromSize(
                Rect.fromLTWH(biggest.width / 2 - width,
                    biggest.height / 2 - bigHeight / 2, bigWidth, bigHeight),
                biggest);

            RelativeRect end = RelativeRect.fromSize(
                Rect.fromLTWH(biggest.width / 2 - width / 2, biggest.height / 2 - bigWidth, width, height),
                biggest);

            RelativeRect start2 = RelativeRect.fromSize(
                Rect.fromLTWH(biggest.width / 2,
                    biggest.height / 2 , 0, 0),
                biggest);
            RelativeRect end2 = RelativeRect.fromSize(
                Rect.fromLTWH(0, biggest.height / 2 - height / 2,
                    biggest.width, height),
                biggest);

      return Stack(
        children: [
          PositionedTransition(
            rect: RelativeRectTween(begin: start2, end: end2).animate(
                CurvedAnimation(parent: _controller2, curve: Curves.easeOutSine)),
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: Center(child: Text( widget.name,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                  )
              ) ) ,
            ),
          ),
          PositionedTransition(
            rect: RelativeRectTween(begin: start, end: end).animate(
                CurvedAnimation(
                    parent: _controller, curve: Curves.easeOutSine)),
            child:Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: widget.image,
                    fit: BoxFit.contain,
                  ),
                ),
            ),
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
  late List<String> planetString;

  late int currentIndex;
  late PageController _pageController;
  @override
  void initState() {
    super.initState();

    currentIndex = 0;
    _pageController = PageController(initialPage: 0);
    planetImages = [];
    planetImages.add(const AssetImage('images/ArancioBlu.png'));
    planetImages.add(const AssetImage('images/Avezzano.png'));
    planetImages.add(const AssetImage('images/ZurroneII.png'));

    planetString = [];
    planetString.add("Mercurio");
    planetString.add("Giove");
    planetString.add("Saturno");
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
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeIn);
                              },
                              child: const Text("Left"))),
                      Flexible(
                          child: Planet(
                              image: planetImages[position],
                              name: planetString[position])
                      ),
                      Flexible(
                          child: TextButton(
                              onPressed: () {
                                if (currentIndex >= planetImages.length - 1) {
                                  return;
                                }
                                setState(() {
                                  currentIndex++;
                                });
                                _pageController.animateToPage(currentIndex,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeIn);
                              },
                              child: const Text("Right"))),
                    ],
                  ),
                );
              },
              controller: _pageController),
        ));
  }
}
