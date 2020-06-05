import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swipe_stack/swipe_stack.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Color> color = [Color(0xff80E7BA), Color(0xffCB616C), Color(0xffFCD689)];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Center(
          child: Container(
            width: 300,
            height: 400,
            child: SwipeStack(
              children: [for (var i = 0; i < 100; i++) i].map((int index) {
                return SwiperItem(
                    builder: (SwiperPosition position, double progress) {
                  return Card(
                    elevation: 4,
                    color: color[index % 3],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Container(
                      decoration: BoxDecoration(
                        color: color[index % 3],
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      ),
                      child: progress == 0
                          ? Container()
                          : Container(
                              alignment: position == SwiperPosition.Right
                                  ? Alignment.topLeft
                                  : Alignment.topRight,
                              child: position == SwiperPosition.Right
                                  ? Opacity(
                                      opacity: progress * 1.5 <= 100
                                          ? progress * 1.5 / 100
                                          : 1.0,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 80,
                                          width: 80,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: Colors.green),
                                          child: Icon(
                                            FontAwesomeIcons.check,
                                            color: Colors.white,
                                            size: 50,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Opacity(
                                      opacity: progress * 1.5 <= 100
                                          ? progress * 1.5 / 100
                                          : 1.0,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 80,
                                          width: 80,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: Colors.red),
                                          child: Icon(
                                            FontAwesomeIcons.times,
                                            color: Colors.white,
                                            size: 50,
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                    ),
                  );
                });
              }).toList(),
              visibleCount: 3,
              maxAngle: 30,
              stackFrom: StackFrom.Bottom,
              translationInterval: 6,
              scaleInterval: 0.03,
              onEnd: () => debugPrint("onEnd"),
              onSwipe: (int index, SwiperPosition position) =>
                  debugPrint("onSwipe $index $position"),
              onRewind: (int index, SwiperPosition position) =>
                  debugPrint("onRewind $index $position"),
            ),
          ),
        ));
  }
}
