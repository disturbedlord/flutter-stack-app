import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swipeable_tinder_card/swipeable_tinder_card.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Color> color = [
    Colors.blue[300],
    Colors.orange[300],
    Colors.red[300],
    Colors.green[300],
  ];

  String t = "Swipe";
  Alignment ali = Alignment.topLeft;
  double opacity = 0.0;
  bool changing = false;
  IconData icon;
  Color col;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: TinderSwapCard(
            totalNum: 100,
            stackNum: 5,
            animDuration: 20,
            // swipeEdge: 4.0,
            // cardController: ,
            maxHeight: MediaQuery.of(context).size.height * 0.7,
            maxWidth: MediaQuery.of(context).size.width * 0.7,
            minWidth: MediaQuery.of(context).size.width * 0.6,
            minHeight: MediaQuery.of(context).size.height * 0.6,
            cardBuilder: (context, index) {
              return CardCard(
                  index: index,
                  color: color,
                  ali: ali,
                  opacity: opacity,
                  col: col,
                  icon: icon);
            },
            swipeCompleteCallback:
                (CardSwipeOrientation orientation, int index) {
              /// Get orientation & index of swiped card!
              print(orientation);
              print(index);
            },
            swipeUpdateCallback: (DragUpdateDetails details, Alignment align) {
              changing = true;
              print(details);

              /// Get swiping card's alignment
              if (align.x < -1) {
                //Card is LEFT swiping
                print("left");
                setState(() {
                  icon = FontAwesomeIcons.times;
                  ali = Alignment.topRight;
                  col = Colors.red;
                  opacity = align.x == 0
                      ? 0
                      : -((align.x * 2) / 10) < 1.0 ? -((align.x * 2) / 10) : 0;
                  print(align.x);
                });
              } else if (align.x > 1) {
                //Card is RIGHT swiping
                print("right");
                setState(() {
                  t = "Right";
                  icon = FontAwesomeIcons.check;
                  col = Colors.green;
                  ali = Alignment.topLeft;
                  opacity = align.x == 0
                      ? 0
                      : ((align.x * 2) / 10) < 1.0 ? ((align.x * 2) / 10) : 0;
                  print(align.x);
                });
              }
            },
          ),
        ),
      ),
    );
  }
}

class CardCard extends StatelessWidget {
  const CardCard({
    Key key,
    @required this.index,
    @required this.color,
    @required this.ali,
    @required this.opacity,
    @required this.col,
    @required this.icon,
  }) : super(key: key);

  final List<Color> color;
  final Alignment ali;
  final double opacity;
  final Color col;
  final IconData icon;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Card(
        color: color[index % 3],
        child: Container(
          alignment: ali,
          child: Opacity(
            opacity: opacity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                    color: col, borderRadius: BorderRadius.circular(100)),
                child: Center(
                    child: Icon(
                  icon,
                  size: 50,
                  color: Colors.white,
                )),
              ),
            ),
          ),
        ),
      ),
      Container(
        height: 80,
        width: 80,
        color: Colors.blue[300],
      ),
    ]);
  }
}

class CardWidgetPositioned extends StatelessWidget {
  const CardWidgetPositioned({
    Key key,
    @required this.color,
    @required this.bottom,
    @required this.width,
  }) : super(key: key);

  final Color color;
  final double bottom;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: Container(
        width: width,
        height: 450,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
    );
  }
}
