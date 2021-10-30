import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'my_home_page/my_home_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await  Firebase.initializeApp();
  FirebaseAuth.instance;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage())));
  }
  @override
  Widget build(BuildContext context) {
    bool lightMode =
    MediaQuery.of(context).platformBrightness == Brightness.light;
    return SafeArea(
      child: Scaffold(
        backgroundColor:
        lightMode ? const Color(0xffe1f5fe) : const Color(0xff042a49),
        body: Center(
            child: lightMode
                ? Image.asset('assets/splash/splash_logo.png',)
                : Image.asset('assets/splash/splash_logo.png')),
      ),
    );
  }
}

