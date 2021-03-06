import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/main_page/display_image.dart';
import 'package:wallpaper_app/main_page/search_result.dart';
import 'package:wallpaper_app/model/image_model.dart';
import 'categorey.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<ImageModel> images=[];
  List imageName=['Architectural','Car','Editorial','Fashion','Galaxy','joker','Photojournalism','Portrait ','Sports','Still_Life'];
  List categoryName=['Architectural','Car','Editorial','Fashion','Galaxy','Joker','Journalism','Portrait','Sports','Still_Life'];
  getImage()async{
    var apikey ='563492ad6f9170000100000140ccbf96712846169984f406bc0d064a';
    http.Response  response = await http.get(Uri.parse('https://api.pexels.com/v1/curated?page=2&per_page=80'),
    headers: {
      "Authorization":apikey,
    }
    );
    var data= jsonDecode(response.body);
    for (var image in data["photos"]){
      images.add(ImageModel.fromJson(image));
    }
    setState(() {

    });
    // var photoId;
    // for(var i=1;i<80;i++){
    //   var photo = jsonDecode(data)['photos'][i]['src']['portrait'];
    //    photoId = jsonDecode(data)['photos'][i]['photographer_id'];
    //   photo_id.add(photoId);
    //   trendimage.add(photo);
    // }
    // setState(() {
    // });
  }

  @override
  void initState() {
    getImage();
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
           body: SingleChildScrollView(
             child: Container(
        decoration:  BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/background_photo/main_background.jpg',
                  ),
                  fit: BoxFit.cover)),
        child: Container(
          color: Colors.black.withOpacity(0.5),
          child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(20),
                  child: const Text('Wallpaper',style: TextStyle(
                    color: Colors.white,
                    fontSize: 25
                  ),),
                ),
                 SizedBox(height: 10,),
                Container(
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white54),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child:  TextField(
                    onSubmitted: (value)=>Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchResult(name:value,))),
                    decoration: InputDecoration(
                      hintText: 'search',
                        suffixIcon: Icon(Icons.search,color: Colors.white,),
                        hintStyle:TextStyle(
                          color: Colors.white,
                          fontSize: 20
                        ),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      contentPadding:EdgeInsets.symmetric(vertical: 15,horizontal: 20)
                    ),
                  ),
                ),
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 8),
                      child: Text('CLASSIFICATION',style: TextStyle(
                        color: Colors.white,
                        fontSize: 20
                      ),),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                //:TODO YAHA SY SURU KAR NA HA CATEGORY PORTION
               Container(
                 width: MediaQuery.of(context).size.width,
                 height: 80,
                 child: ListView.builder(
                   padding: EdgeInsets.symmetric(horizontal: 10),
                   scrollDirection: Axis.horizontal,
                   itemCount: 10,
                   itemBuilder: (context,index){
                     return Category(image: imageName[index],text: categoryName[index],onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchResult(name: imageName[index],))),);
                   },
                 ),
               ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 20),
                      child: Text('TREND PHOTOS',style: TextStyle(
                          color: Colors.white,
                          fontSize: 20
                      ),),
                    ),
                  ],
                ),
                 Container(
                   child: ListView.builder(
                     shrinkWrap: true,
                     physics: NeverScrollableScrollPhysics(),
                     itemCount: images.length,
                       itemBuilder:(context,index){
                         if(images==null){
                           return CircularProgressIndicator();
                         }
                         return Container(
                           width:MediaQuery.of(context).size.width,
                           padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),

                           height:MediaQuery.of(context).size.width/1.3,
                           child:Hero(
                             tag: images[index],
                             child: Container(
                               decoration: BoxDecoration(
                               border: Border.all(color: Colors.white.withOpacity(0.5)),
                                 borderRadius: BorderRadius.circular(5)
                               ),
                               child: ClipRRect(
                                 borderRadius: BorderRadius.circular(5),
                                 child: GestureDetector(
                                   onTap: (){
                                     Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageDisplay(image: images[index].src!.large2x.toString(),photoId: images[index].id,)));
                                   },
                                   child: Image.network(images[index].src!.medium.toString(),fit: BoxFit.cover,loadingBuilder:(context, child, loadingProgress) {
                                     if (loadingProgress == null) return child;
                                     return Center(
                                       child: CircularProgressIndicator(),
                                     );
                                   },),
                                 ),
                               ),
                             ),
                           ) ,
                         );
                       } ),
                 )
                ],
          ),
        ),
      ),
           ),
    ));
  }
}
