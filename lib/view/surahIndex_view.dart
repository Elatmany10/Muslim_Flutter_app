import 'package:h_quran/animations/bottomAnimation.dart';
import 'package:h_quran/controller/quranAPI.dart';
import 'package:h_quran/customWidgets/backBtn.dart';
import 'package:h_quran/customWidgets/customImagePos.dart';
import 'package:h_quran/customWidgets/flare.dart';
import 'package:h_quran/customWidgets/loadingShimmer.dart';
import 'package:h_quran/customWidgets/title.dart';
import 'package:h_quran/view/ayahs_view.dart';
import 'package:flutter/material.dart';

class SurahIndex extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: <Widget>[
          FutureBuilder(
            future: QuranAPI().getSurahList(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return LoadingShimmer(
                  text: "السور",
                );
              } else if (snapshot.connectionState == ConnectionState.done &&
                  !snapshot.hasData) {
                return Center(
                    child:
                        Text("خطأ في الاتصال! الرجاء معاودة المحاولة في وقت لاحق :)"));
              } else if (snapshot.hasData == null) {
                return Center(
                    child: Text(
                        "خطأ في الاتصال! الرجاء التحقق من اتصال الانترنت الخاص بك"));
              } else if (snapshot.hasError) {
                return Center(
                    child: Text(
                  "حدث خطأ من جانبنا!\nنحن نحاول إعادة الاتصال :)",
                  textAlign: TextAlign.center,
                ));
              } else if (snapshot.hasData) {
                return Container(
                  padding: EdgeInsets.all(8.0),
                  margin: EdgeInsets.fromLTRB(0, height * 0.2, 0, 0),
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: Color(0xffee8f8b),
                        height: 2.0,
                      );
                    },
                    itemCount: snapshot.data.surahs.length,
                    itemBuilder: (context, index) {
                      return WidgetAnimator(
                        ListTile(
                          onLongPress: () {
                            showDialog(
                              context: context,
                              builder: (context) => SurahInformation(
                                surahNumber: snapshot.data.surahs[index].number,
                                arabicName:
                                    "${snapshot.data.surahs[index].name}",
                                englishName:
                                    "${snapshot.data.surahs[index].englishName}",
                                ayahs: snapshot.data.surahs[index].ayahs.length,
                                revelationType:
                                    "${snapshot.data.surahs[index].revelationType}",
                                englishNameTranslation:
                                    "${snapshot.data.surahs[index].englishNameTranslation}",
                              ),
                            );
                          },
                          leading: Text(
                            "${snapshot.data.surahs[index].number}",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          title: Text(
                            "${snapshot.data.surahs[index].englishName}",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          subtitle: Text(
                              "${snapshot.data.surahs[index].englishNameTranslation}"),
                          trailing: Text(
                            "${snapshot.data.surahs[index].name}",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SurahAyats(
                                          ayatsList:
                                              snapshot.data.surahs[index].ayahs,
                                          surahName:
                                              snapshot.data.surahs[index].name,
                                          surahEnglishName: snapshot
                                              .data.surahs[index].englishName,
                                          englishMeaning: snapshot
                                              .data
                                              .surahs[index]
                                              .englishNameTranslation,
                                        )));
                          },
                        ),
                      );
                    },
                  ),
                );
              } else {
                return Center(
                    child: Text("خطأ في الاتصال! الرجاء معاودة المحاولة في وقت لاحق"));
              }
            },
          ),
          CustomImage(
            opacity: 0.3,
            height: height * 0.17,
            networkImgURL: 'https://i.ibb.co/WvWbc7Y/kaaba.png',
          ),
          BackBtn(),
          CustomTitle(
            title: "فهرس السور",
          ),
          Flare(
            color: Color(0xfff9e9b8),
            offset: Offset(width, -height),
            bottom: -50,
            flareDuration: Duration(seconds: 17),
            left: 100,
            height: 60,
            width: 60,
          ),
          Flare(
            color: Color(0xfff9e9b8),
            offset: Offset(width, -height),
            bottom: -50,
            flareDuration: Duration(seconds: 12),
            left: 10,
            height: 25,
            width: 25,
          ),
          Flare(
            color: Color(0xfff9e9b8),
            offset: Offset(width, -height),
            bottom: -40,
            left: -100,
            flareDuration: Duration(seconds: 18),
            height: 50,
            width: 50,
          ),
          Flare(
            color: Color(0xfff9e9b8),
            offset: Offset(width, -height),
            bottom: -50,
            left: -80,
            flareDuration: Duration(seconds: 15),
            height: 50,
            width: 50,
          ),
          Flare(
            color: Color(0xfff9e9b8),
            offset: Offset(width, -height),
            bottom: -20,
            left: -120,
            flareDuration: Duration(seconds: 12),
            height: 40,
            width: 40,
          ),
        ],
      ),
    ));
  }
}

class SurahInformation extends StatefulWidget {
  final int surahNumber;
  final String arabicName;
  final String englishName;
  final String englishNameTranslation;
  final int ayahs;
  final String revelationType;

  SurahInformation(
      {this.arabicName,
      this.surahNumber,
      this.ayahs,
      this.englishName,
      this.englishNameTranslation,
      this.revelationType});

  @override
  _SurahInformationState createState() => _SurahInformationState();
}

class _SurahInformationState extends State<SurahInformation>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return ScaleTransition(
      scale: scaleAnimation,
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
            width: width * 0.75,
            height: height * 0.37,
            decoration: ShapeDecoration(
                color: Colors.grey[800],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  "معلومات السورة",
                  style: Theme.of(context).textTheme.headline2,
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      widget.englishName,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(
                      widget.arabicName,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
                Text("ايات: ${widget.ayahs}"),
                Text("رقم السورة: ${widget.surahNumber}"),
                Text("ميعاد النزول: ${widget.revelationType}"),
                //Text("المعني: ${widget.englishNameTranslation}"),
                SizedBox(
                  height: height * 0.02,
                ),
                SizedBox(
                  height: height * 0.05,
                  child: FlatButton(
                      color: Color(0xffee8f8b),
                      onPressed: () => Navigator.pop(context),
                      child: Text("حسنا")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
