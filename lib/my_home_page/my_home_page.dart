import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wallpaper_app/my_home_page/sign_button.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:wallpaper_app/my_home_page/sign_up_page.dart';

import 'constant.dart';
import 'login_button.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:Builder(
          builder:(context){

           return SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: homePageDecoration,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.black38,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:[
                   const SizedBox(height: 70,),
                   const Text('Welcome to Here',style: welcomeTextStyle),
                    Container(
                      alignment: Alignment.center,
                      padding:const EdgeInsets.symmetric(horizontal: 30,vertical: 10) ,
                      child: const Text('Let`s sign up and download best wallpaper. There are many categories so just go and Explore your frame',
                          style:descriptionText),
                    ),
                   Column(children: [
                     LoginButton(text: 'Log in',onpress:(){}),
                    const SizedBox(height: 20,),
                     SignupButton(onPress: ()=>showModalBottomSheet(
                         backgroundColor: Colors.transparent,
                         context: context, builder: (context)=>SignupPage()),),
                   ],)
                  ],
                ),
              ),
            ),
          );},
        )
      ),
    );
  }
}
