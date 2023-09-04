//@dart=2.9
import 'package:country/constant/theme.dart';
import 'package:country/repository/save/shared_pref_service.dart';
import 'package:country/ui/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CountryApp extends StatefulWidget {
  const CountryApp({Key key}) : super(key: key);

  @override
  _CountryAppState createState() => _CountryAppState();
}

class _CountryAppState extends State<CountryApp> {
  final SharedPrefService spService = SharedPrefService();

  @override
  void initState() {
    super.initState();
    spService.getBookmarks(context);
    spService.getDownloads(context);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      // To Prevent the App from going in Lanscape Mode, We lock it in Potrait
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      // This Allows us to change the Naviagtion and Status Bar Color of Device
      statusBarColor: Color(0xff4285f4), //top bar color
      statusBarIconBrightness: Brightness.light, //top bar icons
      systemNavigationBarColor: Color(0xfff9f4f4), //bottom bar color
      systemNavigationBarIconBrightness: Brightness.dark, //bottom bar icons
    ));
    return MaterialApp(
      title: 'Country app',
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
      theme: kAppTheme,
    );
  }
}
