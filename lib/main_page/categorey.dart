import 'package:flutter/material.dart';


class Category extends StatelessWidget {
  Category({this.onTap,this.text,this.image});
 final text;
 final image;
 final onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(width: 130,
        margin: EdgeInsets.symmetric(horizontal: 10),
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          image:DecorationImage(image:AssetImage('assets/photo_category/$image.jpg'),fit: BoxFit.cover),
        ),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(5),
              color: Colors.black38
          ),
          child: Text(text,style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 20
          ),),
        ),
      ),
    );
  }
}
