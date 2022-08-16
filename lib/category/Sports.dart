// ignore_for_file: prefer_const_constructors, camel_case_types, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Controller/Provider.dart';
import '../Screens/MainScreen.dart';
import '../shared/network/local/favourite_model.dart';

class sports extends StatefulWidget {
  const sports({Key? key}) : super(key: key);

  @override
  _sportsState createState() => _sportsState();
}

class _sportsState extends State<sports> {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return  Scaffold(
        appBar: AppBar(
            centerTitle: true,
            leading: IconButton(onPressed: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
                return home_screen();
              }));
            } , icon: Icon(Icons.arrow_back_ios_outlined)),

            title: Text(
              'Sports',
              style: TextStyle(
                  fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          'lib/images/appbar.jpg'),
                      fit: BoxFit.cover
                  )),
            )),
        body:
        Column(children: [
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index)=>Consumer<DataProvider>(
                    builder: (context, radiodata, Widget? child)
                    {
                      return radiolistile(
                        checkfavorite: ()async{
                          FavouriteModel model = FavouriteModel(
                            id: radiodata.allSportsItems[index].id,
                            name: radiodata.allSportsItems[index].name,
                            type: radiodata.allSportsItems[index].type,
                            imageUrl: radiodata.allSportsItems[index].imageUrl,
                            soundUrl: radiodata.allSportsItems[index].soundUrl,
                            isFav: radiodata.allSportsItems[index].isFav! == "true" ? "false" : "true",
                          );
                          await radiodata.toggleFavIcon(
                            favouriteModel: model,
                          );                        },
                        isfav: radiodata.allSportsItems[index].isFav! == "true" ? true : false,
                        title: radiodata.allSportsItems[index].name!,
                        subtitle: radiodata.allSportsItems[index].type!,
                        image: radiodata.allSportsItems[index].imageUrl!,
                        ontap: (){
                          radiodata.changeBar(radiodata.allSportsItems[index]);
                        },
                        // ontap: () {
                        //
                        //   setState(() {
                        //     DataProvider.title = radiodata.allSportsItems[index].name!;
                        //     DataProvider.category = radiodata.allSportsItems[index].type!;
                        //     DataProvider.image = radiodata.allSportsItems[index].imageUrl!;
                        //     DataProvider.soundUrl = radiodata.allSportsItems[index].soundUrl!;
                        //     DataProvider.playPauseIcon = Icons.pause;
                        //     DataProvider.id = radiodata.allSportsItems[index].id!;
                        //
                        //     Provider.of<DataProvider>(context, listen: false).
                        //     getAudio(radiodata.allSportsItems[index].soundUrl);
                        //
                        //   });},
                      );
                    }
                ),
                separatorBuilder:(context,index)=>SizedBox(height: 10,),
                itemCount: Provider.of<DataProvider>(context).allSportsItems.length),
          ),
          InkWell(
            onTap: () {
              setState(() {
                DataProvider.playPauseIcon = DataProvider.playPauseIcon == Icons.play_arrow
                    ? Icons.pause
                    : Icons.play_arrow;
              });
              Provider.of<DataProvider>(context, listen: false)
                  .getAudio2(DataProvider.soundUrl);
            },
            child: Container(
              color: Colors.black.withOpacity(0.2),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: size.height / 70),
                child: ListTile(
                  title: Row(
                    children: [
                      Image.asset(
                        DataProvider.image.toString(),
                        width: 50,
                        height: 50,
                      ),
                      SizedBox(width: size.width / 35),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(DataProvider.title.toString()),
                          Text(
                            DataProvider.category.toString(),
                            style: TextStyle(color: Colors.grey[600]),
                          )
                        ],
                      )
                    ],
                  ),
                  trailing: Icon(
                    DataProvider.playPauseIcon,
                    size: size.height / 22,
                  ),
                ),
              ),
            ),
          )

        ] ,
        )
    );
  }
}