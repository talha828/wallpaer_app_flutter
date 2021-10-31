import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:wallpaper_app/user_account/login_page/login_button.dart';
import 'package:cool_alert/cool_alert.dart';

import '../../main_page/main_screen.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  var email;
  var password;
  var confrimPassword;

  userSignup(){
   if(email!=null||password!=null||confrimPassword!=null){
     if(password==confrimPassword){
       FirebaseAuth _auth=FirebaseAuth.instance;
       _auth.createUserWithEmailAndPassword(email: email, password: password).then((value) => Navigator.push(context, MaterialPageRoute(builder: (context)=>MainScreen()))).catchError((e)=>CoolAlert.show(
         context: context,
         type: CoolAlertType.error,
         text: "something wants wrong",
       ));
     }
     else{
       CoolAlert.show(
         context: context,
         type: CoolAlertType.error,
         text: "Check your password",
       );
     }
   }
   else{
     CoolAlert.show(
       context: context,
       type: CoolAlertType.error,
       text: "Please fill your credentials correctly",
     );
   }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: Colors.black)
                        ),
                        child: Image.asset('assets/splash/splash_logo.png',fit: BoxFit.cover,),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child:Text('Let`s come with us',style: TextStyle(
                            fontSize: 20,
                          ),) ,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10,horizontal: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],                ),
                  child: TextField(
                    onChanged: (value){
                      email=value;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Your Email',
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 30,vertical: 10)
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10,horizontal: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],                ),
                  child: TextField(
                    obscureText: true,
                    onChanged: (value){
                      password=value;
                    },
                    decoration: InputDecoration(
                        hintText: 'Type Password',
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 30,vertical: 10)
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10,horizontal: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],                ),
                  child: TextField(
                    onChanged: (value){
                      confrimPassword=value;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: 'Confirm Password',
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 30,vertical: 10)
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                LoginButton(text: 'Sign up',onpress: userSignup,)
              ],
            ),
          ),
        )));
  }
}
