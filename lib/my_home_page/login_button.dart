import 'package:flutter/material.dart';


class LoginButton extends StatelessWidget {
LoginButton({this.onpress,this.text});
    final onpress;
    final text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpress,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(30),
        ),
        width: MediaQuery.of(context).size.width/1.2,
        padding: EdgeInsets.symmetric(horizontal: 30,vertical: 15),
        child: Text(text,style: TextStyle(
            color: Colors.white,
            fontSize: 20

        ),),),
    );
  }
}
