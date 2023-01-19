import 'package:flutter/material.dart';
import 'package:flutter_overboard/flutter_overboard.dart';

class OnBoardingCard extends StatelessWidget {

  /*final pages = [
    PageModel(
        color: Colors.grey[700],
        imageAssetPath: 'assets/grad_logo.png',
        title: "ختمة القرأن الكريم",
        body:
            "\"انا نزلنا الذكر وانا له لحافظون\"\n",
        doAnimateImage: true),
    *//*PageModel(
        color: const Color(0xff106791),
        imageAssetPath: 'assets/ui.png',
        title: "تصميم رائع وجميل",
        body:
            "I have worked hard to choose beautiful Colors, Animations and overall an appealing Design for this Beautiful Book",
        doAnimateImage: true),*//*
    PageModel(
        color: const Color(0xff664d7b),
        imageAssetPath: 'assets/sajdaIndex.png',
        title: "فهرس السجدة",
        body:
            "الآن ، مع فهرس السجدة و يمكنك فتح أي سجدة في القرآن مباشرة من القائمة مع معلومات مختصرة عنها.",
        doAnimateImage: true),
    PageModel(
        color: const Color(0xff04364f),
        imageAssetPath: 'assets/easyNav.png',
        title: "سهل الاستكشاف",
        body:
            "Open Juzz, Surah or Sajda directly from the index. Long press any Surah or Sajda will show brief information about it.",
        doAnimateImage: true),
    PageModel(
        color: Colors.grey[850],
        imageAssetPath: 'assets/drawer3d.gif',
        title: "3D Animated Drawer",
        body:
            "We have introduced a unique 3D Animated drawer. Share your feedback about such ideas.",
        doAnimateImage: true),
  ];*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OverBoard(
        //pages: pages,
        showBullets: true,
        skipCallback: () {
          Navigator.pushNamed(context, '/homeScreen');
        },
        finishCallback: () {
          Navigator.pushNamed(context, '/homeScreen');
        },
      ),
    );
  }
}
