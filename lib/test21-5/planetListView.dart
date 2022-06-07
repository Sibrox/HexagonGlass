import 'package:flutter/material.dart';

class Planet extends StatefulWidget {
  final AssetImage image;
  const Planet({Key? key, required this.image}) : super(key: key);

  @override
  _PlanetState createState() => _PlanetState();
}

class _PlanetState extends State<Planet> with TickerProviderStateMixin {
  @override
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 1000),
    vsync: this,
  );

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOutBack,
  );

  late double width;
  late double height;

  late double widthAnimated;
  late double heightAnimated;

  late double positionAnimated;
  late bool isSelected;

  late double boxInfoWidthAnim;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller.forward();
    height = width = 200;
    heightAnimated = widthAnimated = 200;
    positionAnimated = boxInfoWidthAnim = 0;
    isSelected = false;
  }

  @override
  Widget build(BuildContext context) {
    var ilResto = Stack(
      alignment: Alignment.center,
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 400),
          curve: Curves.bounceOut,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.green),
          height: 180,
          width: boxInfoWidthAnim,
        ),
        AnimatedPositioned(
            child: GestureDetector(
                onTapDown: (tapDetails) => {
                      setState(() {
                        heightAnimated = widthAnimated = widthAnimated / 1.2;
                      })
                    },
                onTapUp: (tapDetails) {
                  setState(() {
                    if (!isSelected) {
                      boxInfoWidthAnim = 300;
                      positionAnimated = 150;
                      heightAnimated = widthAnimated = widthAnimated * 1.4;
                    } else {
                      boxInfoWidthAnim = 0;
                      positionAnimated = 0;
                      heightAnimated = widthAnimated = widthAnimated * 1.2;
                    }
                    isSelected = !isSelected;
                  });
                },
                child: Container(
                    decoration: BoxDecoration(
                  image: DecorationImage(
                    image: widget.image,
                    fit: BoxFit.contain,
                  ),
                ))),
            width: widthAnimated,
            height: heightAnimated,
            left: (MediaQuery.of(context).size.width / 2) -
                width / 2 -
                positionAnimated,
            duration: const Duration(milliseconds: 400),
            curve: Curves.bounceOut),
      ],
    );

    return Center(
        child: GestureDetector(
            onTapDown: (tapDetails) => {
                  setState(() {
                    heightAnimated = widthAnimated = widthAnimated / 1.2;
                  })
                },
            onTapUp: (tapDetails) {
              setState(() {
                if (!isSelected) {
                  boxInfoWidthAnim = 300;
                  positionAnimated = 150;
                  heightAnimated = widthAnimated = widthAnimated * 1.4;
                } else {
                  boxInfoWidthAnim = 0;
                  positionAnimated = 0;
                  heightAnimated = widthAnimated = widthAnimated * 1.2;
                }
                isSelected = !isSelected;
              });
            },
            child: AnimatedContainer(
                width: widthAnimated,
                height: heightAnimated,
                duration: const Duration(milliseconds: 400),
                curve: Curves.bounceOut,
                child: Stack(
                  children: [
                    Positioned(
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: widget.image,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),

                    )
                  ],
                ))));
  }
}

class PlanetListView extends StatefulWidget {
  const PlanetListView({Key? key}) : super(key: key);

  @override
  _PlanetListViewState createState() => _PlanetListViewState();
}

class _PlanetListViewState extends State<PlanetListView> {
  late List<AssetImage> planetImages;

  @override
  void initState() {
    super.initState();
    planetImages = [];
    planetImages.add(AssetImage('images/ArancioBlu.png'));
    planetImages.add(AssetImage('images/Avezzano.png'));
    planetImages.add(AssetImage('images/ZurroneII.png'));
  }

  @override
  Widget build(BuildContext context) {
    var planets = [];

    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("images/SuDario.png"),
          fit: BoxFit.fill,
        )),
        child: Center(
            child: ListView(
                padding: const EdgeInsets.all(8),
                children: List.generate(
                  planetImages.length,
                  (index) => Container(
                    margin: const EdgeInsets.only(bottom: 30.0),
                    child: Planet(image: planetImages[index]),
                  ),
                ))));
  }
}
