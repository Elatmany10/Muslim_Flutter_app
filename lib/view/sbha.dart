import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../animations/bottomAnimation.dart';
import '../tasbeh/tasbeh_home_screen.dart';

class Sebha extends StatefulWidget {
  final double maxSlide;

  Sebha({@required this.maxSlide});

  @override
  State<Sebha> createState() => _SebhaState();
}

class _SebhaState extends State<Sebha> {
  int _counter;
  bool isClick = true;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  _dismissDialog() {
    Navigator.pop(context);
  }

  void _showMaterialDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Notification',
              textAlign: TextAlign.right,
            ),
            content: Text(
              'Clear the history',
              textAlign: TextAlign.left,
            ),
            actions: <Widget>[
              // ignore: deprecated_member_use
              FlatButton(
                  onPressed: () {
                    _dismissDialog();
                  },
                  child: Text('No')),
              // ignore: deprecated_member_use
              FlatButton(
                onPressed: () {
                  _dismissDialog();
                  removeCounter();
                  setState(() {
                    _counter = 0;
                  });
                },
                child: Text('yes'),
              )
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    getCounter();
  }

  /*-----------------------------------------------------------------------------------------------*/
  /*---------------------------- get counter from shared preferences ------------------------------*/
  /*-----------------------------------------------------------------------------------------------*/
  getCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = (prefs.getInt("counter") ?? 0);
    });
  }

  /*-----------------------------------------------------------------------------------------------*/
  /*---------------------------- Set counter to shared preferences ------------------------------*/
  /*-----------------------------------------------------------------------------------------------*/
  setCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("counter", _counter);
  }

  /*-----------------------------------------------------------------------------------------------*/
  /*---------------------------- delete counter from shared preferences ------------------------------*/
  /*-----------------------------------------------------------------------------------------------*/
  removeCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("counter");
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: const Color(0xff2E144B),
        child: Stack(
          fit: StackFit.expand,
          children: [
            _CalligraphyAzkar(),
            _AppNameAzkar(),
            _QuranRailAzkar(),
            ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 200),
                  child: Container(
                    height: 250,
                    //width: 250,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/sbha.png'))),
                    child: Center(
                        child: Text(
                      '$_counter',
                      style: TextStyle(fontSize: 40.0, color: Colors.white),
                    )),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: height * 0.01,horizontal: width * 0.3),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 3),
                        borderRadius: BorderRadius.circular(30)),
                    width: width * 0.3,
                    height: height * 0.06,
                    child: MaterialButton(
                      shape: StadiumBorder(),
                      onPressed: () {
                        _incrementCounter();
                      },
                      child: WidgetAnimator(Text("تسبيح",
                          style: TextStyle(
                              fontSize: height * 0.023,
                              fontWeight: FontWeight.w600))),
                      color: Color(0xff2E144B),
                    ),
                  ),
                ),
                SizedBox(
                  height: 140.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //_TasbehBtn(),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: height * 0.01,horizontal: width * 0.05),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 3),
                            borderRadius: BorderRadius.circular(30)),
                        width: width * 0.3,
                        height: height * 0.06,
                        child: MaterialButton(
                          shape: StadiumBorder(),
                          onPressed: () {
                            Navigator.of(context).pushNamed('/azkarSbha');
                          },
                          child: WidgetAnimator(Text("ذكر",
                              style: TextStyle(
                                  fontSize: height * 0.023,
                                  fontWeight: FontWeight.w600))),
                          color: Color(0xff2E144B),
                        ),
                      ),
                    ),
                    //_ClearBtn(),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: height * 0.01,horizontal: width * 0.05),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 3),
                            borderRadius: BorderRadius.circular(30)),
                        width: width * 0.3,
                        height: height * 0.06,
                        child: MaterialButton(
                          shape: StadiumBorder(),
                          onPressed: () {
                            _resetCounter();
                          },
                          child: WidgetAnimator(Text("اعادة",
                              style: TextStyle(
                                  fontSize: height * 0.023,
                                  fontWeight: FontWeight.w600))),
                          color: Color(0xff2E144B),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _AppNameAzkar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.10,
      left: MediaQuery.of(context).size.width * 0.10,
      child: Text(
        "أذكار \n المسلم",
        style: Theme.of(context).textTheme.headline1,
      ),
    );
  }
}

class _CalligraphyAzkar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Positioned(
        right: width * 0.01,
        top: height * 0.070,
        child: Image.asset(
          "assets/grad_logo.png",
          height: height * 0.20,
        ));
  }
}

class _QuranRailAzkar extends StatelessWidget {
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
/*
class _TasbehBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric( vertical:height * 0.01),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: Colors.white,
                width: 3
            ),
            borderRadius: BorderRadius.circular(30)
        ),
        width: width * 0.3,
        height: height * 0.06,
        child: MaterialButton(
          shape: StadiumBorder(),
          onPressed: () {},
          child: WidgetAnimator(Text("تسبيح",
              style: TextStyle(
                  fontSize: height * 0.023, fontWeight: FontWeight.w600))),
          color: Color(0xff145369),
        ),
      ),
    );
  }
}*/
