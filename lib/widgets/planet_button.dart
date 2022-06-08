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

  var animationTime = const Duration(milliseconds: 800);

  late final AnimationController _controllerPlanet = AnimationController(
    duration: animationTime,
    vsync: this,
  );

  late final AnimationController _controllerBox = AnimationController(
    duration: animationTime,
    vsync: this,
  );

  late final AnimationController _controllerIdle = AnimationController(
    duration: animationTime,
    vsync: this,
    lowerBound: 0.8,
  )..repeat(reverse: true);

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controllerIdle,
    curve: Curves.easeOut,
  );

  @override
  void dispose() {
    _controllerBox.dispose();
    _controllerPlanet.dispose();
    _controllerIdle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controllerBox.forward();
    _controllerPlanet.forward();

    return LayoutBuilder(
        builder: (BuildContext contextText, BoxConstraints constraints) {
          final Size biggest = constraints.biggest;

          var width = biggest.width / 4;
          var height = biggest.width / 2;
          var bigWidth = width * 2;
          var bigHeight = height * 2;

          var boxWidth =  biggest.width * 0.9;
          var boxHeight = boxWidth * 0.8;

          RelativeRect startPlanet = RelativeRect.fromSize(
              Rect.fromLTWH(
                  biggest.width / 2 - bigWidth / 2,
                  biggest.height / 2 - bigHeight / 2,
                  bigWidth, bigHeight),
              biggest);

          RelativeRect endPlanet = RelativeRect.fromSize(
              Rect.fromLTWH(
                  biggest.width / 2 - width / 2,
                  (biggest.height - boxHeight) / 2 - height / 3,
                  width, height),
              biggest);

          RelativeRect startBox = RelativeRect.fromSize(
              Rect.fromLTWH(biggest.width / 2,
                  biggest.height / 2 , 0, 0),
              biggest);

          RelativeRect endBox = RelativeRect.fromSize(
              Rect.fromLTWH(
                  (biggest.width - boxWidth) / 2 ,
                  (biggest.height - boxHeight) / 2 + height / 8,
                  boxWidth, boxHeight),
              biggest);

          return Stack(
            children: [
              PositionedTransition(
                rect: RelativeRectTween(begin: startBox, end: endBox).animate(
                    CurvedAnimation(parent: _controllerBox, curve: Curves.elasticIn)),
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
                rect: RelativeRectTween(begin: startPlanet, end: endPlanet).animate(
                    CurvedAnimation(
                        parent: _controllerPlanet, curve: Curves.elasticIn)),
                child: ScaleTransition(
                  scale: _animation,
                  child:  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: widget.image,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              )

            ],
          );
        });
  }
}