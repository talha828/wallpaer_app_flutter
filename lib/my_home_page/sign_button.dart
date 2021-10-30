import 'package:flutter/material.dart';


class SignupButton extends StatelessWidget {
  SignupButton({this.onPress});
  final onPress;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(30),
        ),
        width: MediaQuery.of(context).size.width/1.2,
        padding: EdgeInsets.symmetric(horizontal: 30,vertical: 15),
        child: Text('Sign Up',style: TextStyle(
            color: Colors.white,
            fontSize: 20

        ),),),
    );
  }
}

