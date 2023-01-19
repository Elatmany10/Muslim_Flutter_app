import 'package:flutter/material.dart';
import 'appVersion.dart';



class MyDrawer extends StatelessWidget {
  myListTile(BuildContext context, double height, IconData tileIcon,
      String title, String pushName) {
    return Card(
      color: Color(0xff2E144B),
      child: ListTile(
        leading: Icon(tileIcon, size: height * 0.035),
        title: Text(title),
        onTap: () => Navigator.pushNamed(context, pushName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SizedBox(
      width: width * 0.835,
      height: height,
      child: Material(
        color: Color(0xff2E144B),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              DrawerAppName(),
              Column(
                children: <Widget>[
                  myListTile(context, height, Icons.format_list_bulleted,
                      "اختر الجزء", "/juzzIndex"),
                  myListTile(context, height, Icons.format_list_numbered,
                      " اختر السورة", "/surahIndex"),
                  myListTile(context, height, Icons.format_align_left,
                      "اختر السجدة", "/sajda"),
                  myListTile(context, height, Icons.menu_book,
                      "شرح القرأن", "/sharhElquran"),
                  myListTile(
                      context, height, Icons.menu_book_sharp, "ازكار", "/azkar"),
                  myListTile(
                      context, height, Icons.menu_book, "السبحة", "/sbha"),
                  myListTile(
                      context, height, Icons.help, "مساعدة", "/help"),
                 /* myListTile(
                      context, height, Icons.help, "القبلة", "/qibla"),*/
                  myListTile(
                      context, height, Icons.share, "مشاركة التطبيق", "/shareApp"),
                ],
              ),
              AppVersion()
            ],
          ),
        ),
      ),
    );
  }
}
class DrawerAppName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          children: <Widget>[
            Text(
              "\nختمة",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: height * 0.025,
                  color: Colors.grey[200]),
            ),
            Text(
              "القرأن الكريم",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[200],
                  fontSize: height * 0.035),
            )
          ],
        ),
        Image.asset('assets/grad_logo.png', height: height * 0.17)
      ],
    );
  }
}
