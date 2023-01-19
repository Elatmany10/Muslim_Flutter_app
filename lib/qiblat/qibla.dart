/*
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import '../qibla/loading_indecator.dart';
import '../qibla/qibla_comps.dart';
import '../qibla/qibla_maps.dart';


class QiblaPage extends StatelessWidget {
  static const String routeName = 'QiblaPage';
  final double maxSlide;

  final _deviceSupport = FlutterQiblah.androidDeviceSensorSupport();

   QiblaPage({Key key, this.maxSlide}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder (
        future: _deviceSupport ,
        builder: (_, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingIndicator();
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error.toString()}"),
            );
          }

          if (snapshot.data) {
            return QiblahCompass();
          } else {
            return QiblahMaps();
          }
        },
      ),
    );
  }
}
*/
