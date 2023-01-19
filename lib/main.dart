import 'package:h_quran/azkar/Azkar_Section_Detail_Screen.dart';
import 'package:h_quran/azkar/Azkar_home_screen.dart';
import 'package:h_quran/sharh_elquran/quran_home_screen.dart';
import 'package:h_quran/sharh_elquran/quran_section_details_screen.dart';
//import 'package:h_quran/qibla/qibla_maps.dart';
//import 'package:h_quran/qibla/qibla_comps.dart';
//import 'package:h_quran/qiblat/qibla.dart';
import 'package:h_quran/tasbeh/tasbeh_home_screen.dart';
import 'package:h_quran/tasbeh/tasbeh_section_details_screen.dart';
import 'package:h_quran/view/quraan_arabic/quraan_arabic.dart';
import 'package:h_quran/view/sbha.dart';
import 'package:h_quran/view/JuzIndex_view.dart';
import 'package:h_quran/view/homeScreen_view.dart';
import 'package:h_quran/view/otherViews/help.dart';
import 'package:h_quran/view/otherViews/introduction.dart';
import 'package:h_quran/view/otherViews/shareApp.dart';
import 'package:h_quran/view/sajdaIndex_view.dart';
import 'package:h_quran/view/surahIndex_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

int initScreen;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = prefs.getInt("initScreen");
  await prefs.setInt("initScreen", 1);
  runApp(MyApp());
}

final darkTheme = ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    backgroundColor: const Color(0xFF212121),
    accentColor: Color(0xff896277),
    accentIconTheme: IconThemeData(color: Colors.black),
    dividerColor: Colors.black12,
    //fontFamily: 'NotoKufiArabic',
    textTheme: const TextTheme(
        subtitle1: TextStyle(
          fontFamily: 'Tajawal',
          fontSize: 22.0,
        ),
        headline1: TextStyle(
            fontFamily: 'NotoKufiArabic-Light',
            fontSize: 42,
            fontWeight: FontWeight.w600),
        headline2: TextStyle(
            fontFamily: 'NotoKufiArabic-Light',
            fontSize: 28,
            fontWeight: FontWeight.w600),
        bodyText1: TextStyle(
            fontFamily: "NotoKufiArabic-Light",
            fontSize: 18,
            fontWeight: FontWeight.w600),
        caption: TextStyle(fontFamily: "NotoKufiArabic-Light", fontSize: 14)));

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar', 'AE'), // English, no country code
      ],
      debugShowCheckedModeBanner: false,
      theme: darkTheme,
      home: Builder(
        builder: (context) => HomeScreen(
          maxSlide: MediaQuery.of(context).size.width * 0.835,
        ),
      ),
      initialRoute: initScreen == 0 || initScreen == null
          ? '/introduction'
          : '/homeScreen',
      routes: {
        '/introduction': (context) => OnBoardingCard(),
        '/homeScreen': (context) => HomeScreen(
              maxSlide: MediaQuery.of(context).size.width * 0.835,
            ),
        '/surahIndex': (context) => SurahIndex(),
        '/surah': (context) => SurahIndex(),
        '/sajda': (context) => Sajda(),
        '/juzzIndex': (context) => JuzIndex(),
        '/help': (context) => Help(),
        '/shareApp': (context) => ShareApp(),
        '/azkar': (context) => const AzkarHome(),
        '/azkarDetails': (context) => const AzkarSectionDetailScreen(),
        '/sbha': (context) => Sebha(),
        '/azkarSbha': (context) => const TasbehHome(),
        '/sharhElquran': (context) => const QuranHome(),
        '/tasbehDetails': (context) => const TasbehSectionDetailScreen(),
        '/quranDetails': (context) => const QuranSectionDetailScreen(),
        //'/qibla': (context) => QiblaPage(),
        //'/qiblah': (context) => QiblahCompass(),
        //'/qibla': (context) => QiblahMaps(),
      },
    );
  }
}
