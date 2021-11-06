import 'dart:typed_data';
import 'package:cool_alert/cool_alert.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:dio/dio.dart';

class ImageDisplay extends StatefulWidget {
  ImageDisplay({this.image,this.photoId});
  final image;
  final photoId;

  @override
  _ImageDisplayState createState() => _ImageDisplayState();
}

class _ImageDisplayState extends State<ImageDisplay> {


  _save() async {
    var isShown = await Permission.storage.request();
    var status = await Permission.storage.status;
    print(status);
    if(status.isDenied){
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: "permission is Denied",
      );
    }
    if(status.isGranted){
      var response = await Dio().get(
          widget.image,
          options: Options(responseType: ResponseType.bytes));
      final result = await ImageGallerySaver.saveImage(
          Uint8List.fromList(response.data),
          quality: 60,
          name:widget.photoId );
      Navigator.pop(context);
      print(result);
      CoolAlert.show(
        context: context,
        type: CoolAlertType.success,
        text: "Image successfully saved",
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Hero(
          tag: widget.image,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children:[  SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.network(widget.image,fit: BoxFit.cover,),
            ),
            GestureDetector(
              onTap: ()=> _save(),
              child: Container(
                height: 70,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 0),
                margin:const  EdgeInsets.symmetric(horizontal: 70,vertical: 60),
                decoration: BoxDecoration(
                  color: Colors.black45.withOpacity(0.3),
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(50),

                ),
                child: const Text('Click the button Image will save on your gallery',style: TextStyle(
                color: Colors.white,
              ),),),
            ),
              GestureDetector(
                onTap: ()=>Navigator.pop(context),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20,),
                  child: Text('cancel',style: TextStyle(
                    color: Colors.white,
                    fontSize: 18
                  ),),
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}
