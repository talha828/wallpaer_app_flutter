import 'dart:convert';
import 'package:flutter/material.dart';
import 'display_image.dart';
import 'package:http/http.dart' as http;

class SearchResult extends StatefulWidget {
  SearchResult({this.name});
  final name;

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  List trendimage=[];
  getImage()async{
    var apikey ='563492ad6f9170000100000140ccbf96712846169984f406bc0d064a';
    http.Response  response = await http.get(Uri.parse('https://api.pexels.com/v1/search?query=${widget.name}&per_page=80'),
        headers: {
          "Authorization":apikey,
        }
    );
    String data= response.body;
    for(var i=1;i<80;i++){
      var photo = jsonDecode(data)['photos'][i]['src']['portrait'];
      trendimage.add(photo);
    }
    setState(() {
    });
  }

  @override
  void initState() {
    getImage();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/background_photo/main_background.jpg',
                ),
                fit: BoxFit.cover)),
        child: Container(
            width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.black45.withOpacity(0.5),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(20),
                  child: const Text('Wallpaper',style: TextStyle(
                      color: Colors.white,
                      fontSize: 25
                  ),),
                ),
                const SizedBox(height: 10,),
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
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: TextField(
                    onSubmitted: (value)=>Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchResult(name:value,))),
                    decoration: InputDecoration(
                        hintText: 'search',
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
                  children:  [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 8),
                      child: Text(widget.name ,style: TextStyle(
                          color: Colors.white,
                          fontSize: 20
                      ),),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    child: ListView.builder(
                        physics: ScrollPhysics(),
                        itemCount: trendimage.length,
                        itemBuilder:(context,index){
                          if(trendimage==null){
                            return CircularProgressIndicator();
                          }
                          return Container(
                            width:MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(20),

                            height:MediaQuery.of(context).size.width/1.3,
                            child:Hero(
                              tag: trendimage[index],
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white.withOpacity(0.5)),
                                    borderRadius: BorderRadius.circular(30)
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageDisplay(image: trendimage[index],)));
                                    },
                                    child: Image.network(trendimage[index],fit: BoxFit.cover,loadingBuilder:(context, child, loadingProgress) {
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
                  ),
                )
              ],
            ),
        ),
      ),
    ));
  }
}
