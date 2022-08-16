// ignore_for_file: prefer_const_constructors, avoid_types_as_parameter_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Controller/Provider.dart';
import '../Screens/MainScreen.dart';
import '../shared/network/local/favourite_model.dart';

class Quraan extends StatefulWidget {
  const Quraan({Key? key}) : super(key: key);

  @override
  _QuraanState createState() => _QuraanState();
}

class _QuraanState extends State<Quraan> {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar:AppBar(
            centerTitle:true,
            leading: IconButton(onPressed: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
                return home_screen();
              }));
            } , icon: Icon(Icons.arrow_back_ios_outlined)),

            title:Text('Quraan',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  image:DecorationImage(image: AssetImage('lib/images/appbar.jpg'),
                      fit: BoxFit.cover)),

            )
        ),
        body:Column(children: [
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index)=>Consumer<DataProvider>(
                    builder: (context, radiodata, Widget? child)
                    {
                      return radiolistile(
                        checkfavorite: ()async{
                          FavouriteModel model = FavouriteModel(
                            id: radiodata.allQuranItems[index].id,
                            name: radiodata.allQuranItems[index].name,
                            type: radiodata.allQuranItems[index].type,
                            imageUrl: radiodata.allQuranItems[index].imageUrl,
                            soundUrl: radiodata.allQuranItems[index].soundUrl,
                            isFav: radiodata.allQuranItems[index].isFav! == "true" ? "false" : "true",
                          );
                          await radiodata.toggleFavIcon(
                            favouriteModel: model,
                          );                        },
                        isfav: radiodata.allQuranItems[index].isFav! == "true" ? true : false,
                        title: radiodata.allQuranItems[index].name!,
                        subtitle: radiodata.allQuranItems[index].type!,
                        image: radiodata.allQuranItems[index].imageUrl!,
                        ontap: (){
                          radiodata.changeBar(radiodata.allQuranItems[index]);
                        },
                        // ontap: () {
                        //
                        //   setState(() {
                        //     DataProvider.title = radiodata.allQuranItems[index].name!;
                        //     DataProvider.category = radiodata.allQuranItems[index].type!;
                        //     DataProvider.image = radiodata.allQuranItems[index].imageUrl!;
                        //     DataProvider.soundUrl = radiodata.allQuranItems[index].soundUrl!;
                        //     DataProvider.playPauseIcon = Icons.pause;
                        //     DataProvider.id = radiodata.allQuranItems[index].id!;
                        //
                        //     Provider.of<DataProvider>(context, listen: false)
                        //         .getAudio(radiodata.quraanradio[index].soundUrl);
                        //
                        //   });},
                      );
                    }
                ),
                separatorBuilder:(context,index)=>SizedBox(height: 10,),
                itemCount: Provider.of<DataProvider>(context).allQuranItems.length),
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