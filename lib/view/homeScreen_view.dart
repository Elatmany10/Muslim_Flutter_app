import 'dart:io';
import 'dart:math' as math;

import 'package:h_quran/animations/bottomAnimation.dart';
import 'package:h_quran/customWidgets/appVersion.dart';
import 'package:flutter/material.dart';

import '../customWidgets/Drower.dart';

class HomeScreen extends StatefulWidget {
  final double maxSlide;
  HomeScreen({@required this.maxSlide});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
  }

  void toggle() => animationController.isDismissed
      ? animationController.forward()
      : animationController.reverse();

  bool _canBeDragged;

  void _onDragStart(DragStartDetails details) {
    bool isDragOpenFromLeft = animationController.isDismissed;
    bool isDragCloseFromRight = animationController.isCompleted;
    _canBeDragged = isDragOpenFromLeft || isDragCloseFromRight;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_canBeDragged) {
      double delta = details.primaryDelta / widget.maxSlide;
      animationController.value += delta;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    double _kMinFlingVelocity = 365.0;

    if (animationController.isDismissed || animationController.isCompleted) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >= _kMinFlingVelocity) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;

      animationController.fling(velocity: visualVelocity);
    } else if (animationController.value < 0.5) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: new Text(
          "الخروج من التطبيق",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: new Text("هل انت متأكد ؟"),
        actions: <Widget>[
          FlatButton(
            shape: StadiumBorder(),
            color: Colors.green,
            child: new Text(
              "نعم",
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              exit(0);
            },
          ),
          FlatButton(
            shape: StadiumBorder(),
            color: Colors.white,
            child: new Text(
              "لا",
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: GestureDetector(
        onHorizontalDragStart: _onDragStart,
        onHorizontalDragUpdate: _onDragUpdate,
        onHorizontalDragEnd: _onDragEnd,
        behavior: HitTestBehavior.translucent,
        child: AnimatedBuilder(
          animation: animationController,
          builder: (context, _) {
            return Material(
              color: Colors.grey[850],
              child: SafeArea(
                child: Stack(
                  children: <Widget>[
                    Transform.translate(
                      offset: Offset(
                          widget.maxSlide * (animationController.value - 1), 0),
                      child: Transform(
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.001)
                            ..rotateY(
                                math.pi / 2 * (1 - animationController.value)),
                          alignment: Alignment.centerRight,
                          child: MyDrawer()),
                    ),
                    Transform.translate(
                      offset: Offset(
                          widget.maxSlide * animationController.value, 0),
                      child: Transform(
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.001)
                            ..rotateY(-math.pi / 2 * animationController.value),
                          alignment: Alignment.centerLeft,
                          child: MainScreen()),
                    ),
                    Positioned(
                      top: 4.0 + MediaQuery.of(context).padding.top,
                      left: width * 0.01 +
                          animationController.value * widget.maxSlide,
                      child: IconButton(
                        icon: Icon(Icons.menu),
                        onPressed: toggle,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

}



class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        color: Color(0xff2E144B),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            AppName(),
            Calligraphy(),
            QuranRail(),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[SurahBtn(), JuzzIndexBtn(), SajdaBtn()],
              ),
            ),
            AyahBottom(),
          ],
        ));
  }
}


class AppName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.20,
      left: MediaQuery.of(context).size.width * 0.19,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text("ختمة", style: Theme.of(context).textTheme.headline2),
          Text(
            "القرأن الكريم",
            style: Theme.of(context).textTheme.headline1,
          )
        ],
      ),
    );
  }
}

class Calligraphy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Positioned(
        right: width * 0.01,
        top: height * 0.045,
        child: Image.asset(
          "assets/grad_logo.png",
          height: height * 0.20,
        ));
  }
}

class QuranRail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Positioned(
        left: width * 0,
        bottom: height * 0.0,
        child: Opacity(
          opacity: 0.2,
          child: Image.asset("assets/quranRail.png", height: height * 0.4),
        ));
  }
}

class SurahBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.01),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: Colors.white,
                width: 3
            ),
            borderRadius: BorderRadius.circular(30)
        ),
        width: width * 0.7,
        height: height * 0.06,
        child: MaterialButton(
          shape: StadiumBorder(),
          onPressed: () => Navigator.pushNamed(context, '/surahIndex'),
          child: WidgetAnimator(Text("اختر السورة",
              style: TextStyle(
                  fontSize: height * 0.023, fontWeight: FontWeight.w600))),
          color: Color(0xff2E144B),
          //0xff145369
        ),
      ),
    );
  }
}

class SajdaBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.01),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: Colors.white,
                width: 3
            ),
            borderRadius: BorderRadius.circular(30)
        ),
        width: width * 0.7,
        height: height * 0.06,
        child: MaterialButton(
          shape: StadiumBorder(),
          onPressed: () {
            Navigator.pushNamed(context, '/sajda');
          },
          child: WidgetAnimator(Text("اختر السجدة",
              style: TextStyle(
                  fontSize: height * 0.023, fontWeight: FontWeight.w600))),
          color: Color(0xff2E144B),
        ),
      ),
    );
  }
}

class JuzzIndexBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.01),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 3
          ),
          borderRadius: BorderRadius.circular(30)
        ),
        width: width * 0.7,
        height: height * 0.06,
        child: MaterialButton(
          shape: StadiumBorder(),
          onPressed: () {
            Navigator.pushNamed(context, '/juzzIndex');
          },
          child: WidgetAnimator(Text("اختر الجزء",
              style: TextStyle(
                  fontSize: height * 0.023, fontWeight: FontWeight.w600))),
          color: Color(0xff2E144B),
        ),
      ),
    );
  }
}

class AyahBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            "وقف لله تعالة\n",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
