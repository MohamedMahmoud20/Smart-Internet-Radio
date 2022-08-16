// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Controller/Provider.dart';
import '../Screens/MainScreen.dart';
import '../shared/network/local/favourite_model.dart';


class News extends StatefulWidget {
  const News({Key? key}) : super(key: key);

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(

        appBar:AppBar(
            leading: IconButton(onPressed: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
                return home_screen();
              }));
            } , icon: Icon(Icons.arrow_back_ios_outlined)),
            centerTitle:true,
            title:Text('News',
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
        body:  Column(
          children: [
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index)=>Consumer<DataProvider>(
                      builder: (context, radiodata, Widget? child)
                      {
                        return radiolistile(
                          checkfavorite: ()async{
                            FavouriteModel model = FavouriteModel(
                              id: radiodata.allNewsItems[index].id,
                              name: radiodata.allNewsItems[index].name,
                              type: radiodata.allNewsItems[index].type,
                              imageUrl: radiodata.allNewsItems[index].imageUrl,
                              soundUrl: radiodata.allNewsItems[index].soundUrl,
                              isFav: radiodata.allNewsItems[index].isFav! == "true" ? "false" : "true",
                            );
                            await radiodata.toggleFavIcon(
                              favouriteModel: model,
                            );                          },
                          isfav: radiodata.allNewsItems[index].isFav! == "true" ? true : false,
                          title: radiodata.allNewsItems[index].name!,
                          subtitle: radiodata.allNewsItems[index].type!,
                          image: radiodata.allNewsItems[index].imageUrl!,
                          ontap: (){
                            radiodata.changeBar(radiodata.allNewsItems[index]);
                          },
                          // ontap: () {
                          //
                          //   setState(() {
                          //     DataProvider.title = radiodata.allNewsItems[index].name!;
                          //     DataProvider.category = radiodata.allNewsItems[index].type!;
                          //     DataProvider.image = radiodata.allNewsItems[index].imageUrl!;
                          //     DataProvider.soundUrl = radiodata.allNewsItems[index].soundUrl!;
                          //     DataProvider.playPauseIcon = Icons.pause;
                          //     DataProvider.id = radiodata.allNewsItems[index].id!;
                          //     Provider.of<DataProvider>(context, listen: false)
                          //         .getAudio(radiodata.allNewsItems[index].soundUrl);
                          //
                          //   });
                          //
                          // },
                        );
                      }
                  ),



                  separatorBuilder:(context,index)=>SizedBox(height: 10,),
                  itemCount: Provider.of<DataProvider>(context).allNewsItems.length),
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

