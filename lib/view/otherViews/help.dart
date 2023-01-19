import 'package:h_quran/customWidgets/appVersion.dart';
import 'package:h_quran/customWidgets/backBtn.dart';
import 'package:h_quran/customWidgets/customImagePos.dart';
import 'package:h_quran/customWidgets/title.dart';
import 'package:flutter/material.dart';

class Help extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            CustomImage(
              networkImgURL: "https://i.ibb.co/JyP79Kf/grad-logo.png",
              opacity: 0.3,
              height: MediaQuery.of(context).size.height * 0.18,
            ),
            BackBtn(),
            CustomTitle(title: "المساعدة"),
            HelpGuide(),
            AppVersion(),
          ],
        ),
      ),
    );
  }
}

class HelpGuide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.fromLTRB(0, height * 0.2, 0, height * 0.1),
      child: ListView(
        children: <Widget>[
          GuideContainer(
            guideNo: 1,
            title: "الاتصال بشبكة الإنترنت",
            guideDescription:
            "في الوقت الحالي ، التطبيق غير متاح في وضع القراءة في وضع عدم الاتصال. لذا ، يعد الاتصال بالإنترنت أمرًا ضروريًا للحصول على جميع البيانات."           ),
          GuideContainer(
            title: "فهرس السور و الاجزاء",
            guideNo: 2,
            guideDescription:
                "افتح أي جزء أو سورة أو سجدة مباشرة من الفهرس. تحتوي على ٣٠ ربع و ١١٤ سورة." +
                    " اضغط مع الاستمرار على أي سورة أو سجدة لعرض معلومات مختصرة عنها.",
          ),
          GuideContainer(
            guideNo: 3,
            title: "فهرس السجدة",
            guideDescription:
                "افتح أي اية سجدة مباشرة من الفهرس. يضم ١٥ سجدة." +
                    " علاوة على ذلك ، ستكون هناك معلومات حول كل سجدة بالداخل ، بما في ذلك الجزء و نوع الفصل من السورة",
          ),
          GuideContainer(
            guideNo: 4,
            title: "علامة تبويب مقدمة",
            guideDescription:
                "سيعيد فتح مقدمة التطبيق التي ربما رأيتها عند فتح التطبيق لأول مرة",
          ),
          GuideContainer(
            guideNo: 5,
            title: "التقييم و ردود الفعل",
            guideDescription:
                "يمكنك تقديم ملاحظاتك الثمينة وتقييم تطبيقنا.",
          ),
          GuideContainer(
            guideNo: 6,
            title: "التبليغ عن خطأ",
            guideDescription:
                "إذا رأيت أي خطأ في سياق هذا الكتاب المقدس يرجى الإبلاغ على الرابط التالي:" +
                    "\n\nhttps://api.alquran.cloud",
          ),
          /*GuideContainer(
            guideNo: 7,
            title: "Code Available",
            guideDescription:
                "Code for v1.0.0 is available at the following link: " +
                    "\n\nhttps://github.com/sadiqabubakar526/The_Holy_Quran_App" +
                    "\n\nThe code is only for learning purposes, it has proper LICENSE that you are not allowed to publish this app.",
          ),*/
          GuideContainer(
            guideNo: 8,
            title: "معلومات المطور",
            guideDescription:
                "Name: Taha Elatmany \nEmail: taha.el3tmany10@gmail.com \nGitHub: @Taha.El3tmany10 ",
          )
        ],
      ),
    );
  }
}

class GuideContainer extends StatelessWidget {
  final String title;
  final String guideDescription;
  final int guideNo;

  GuideContainer(
      {@required this.guideNo,
      @required this.title,
      @required this.guideDescription});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Text(
            "\n $title",
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Text(
            guideDescription,
            textAlign: TextAlign.justify,
            style:
                TextStyle(fontSize: MediaQuery.of(context).size.height * 0.020),
          ),
        ],
      ),
    );
  }
}
