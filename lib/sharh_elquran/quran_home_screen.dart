import 'package:flutter/material.dart';
import 'package:h_quran/azkar_models/section_model.dart';
import 'dart:convert';

import 'package:h_quran/sharh_elquran/quran_section_details_screen.dart';


class QuranHome extends StatefulWidget {
  final double maxSlide;

  const QuranHome({@required this.maxSlide});

  @override
  // ignore: library_private_types_in_public_api
  _QuranHomeState createState() => _QuranHomeState();
}

class _QuranHomeState extends State<QuranHome> with TickerProviderStateMixin {
  List<SectionModel> sections = [];

  @override
  void initState() {
    super.initState();
    loadSections();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2E144B),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          fit: StackFit.expand,
          children: [
            _CalligraphyAzkar(),
            _AppNameAzkar(),
            _QuranRailAzkar(),
            Padding(
              padding: const EdgeInsets.only(
                  top: 220,right: 30, left: 30, bottom: 50),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildSectionItem(model: sections[index]),
                itemCount: sections.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSectionItem({SectionModel model}) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => QuranSectionDetailScreen(
              id: model.id,
              title: model.name,
            )));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: height * 0.005),
        child: Container(
          margin: const EdgeInsets.only(top: 12.0),
          width: width * 0.7,
          height: height * 0.07,
          decoration: BoxDecoration(
              color: Color(0xff2E144B),
              borderRadius: BorderRadius.circular(30.0),
              border: Border.all(color: Colors.white, width: 3)),
          child: Center(
              child: Text(
                "${model.name}",
                style: const TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              )),
        ),
      ),
    );
  }

  loadSections() async {
    DefaultAssetBundle.of(context)
        .loadString("assets/database/quran_db.json")
        .then((data) {
      var response = json.decode(data);
      response.forEach((section) {
        SectionModel _section = SectionModel.fromJson(section);
        sections.add(_section);
      });
      setState(() {});
    }).catchError((error) {
      print(error);
    });
  }
}

class _AppNameAzkar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.10,
      left: MediaQuery.of(context).size.width * 0.10,
      child: Text(
        "شرح \n القرأن",
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
          child: Image.asset("assets/quranRail.png", height: height * 0.25),
        ));
  }
}
