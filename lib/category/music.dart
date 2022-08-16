// ignore_for_file: prefer_const_constructors, avoid_types_as_parameter_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Controller/Provider.dart';
import '../Screens/MainScreen.dart';
import '../shared/network/local/favourite_model.dart';

class Music extends StatefulWidget {
  const Music({Key? key}) : super(key: key);

  @override
  _MusicState createState() => _MusicState();
}

class _MusicState extends State<Music> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (BuildContext context) {
                  return home_screen();
                }));
              },
              icon: Icon(Icons.arrow_back_ios_outlined)),
          title: Text(
            'Music',
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('lib/images/appbar.jpg'),
                    fit: BoxFit.cover)),
          )),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) => Consumer<DataProvider>(
                        builder: (context, radiodata, Widget? child) {
                      return radiolistile(
                        checkfavorite: () async {
                          FavouriteModel model = FavouriteModel(
                            id: radiodata.allMusicItems[index].id,
                            name: radiodata.allMusicItems[index].name,
                            type: radiodata.allMusicItems[index].type,
                            imageUrl: radiodata.allMusicItems[index].imageUrl,
                            soundUrl: radiodata.allMusicItems[index].soundUrl,
                            isFav:
                                radiodata.allMusicItems[index].isFav! == "true"
                                    ? "false"
                                    : "true",
                          );
                          await radiodata.toggleFavIcon(
                            favouriteModel: model,
                          );
                        },
                        isfav: radiodata.allMusicItems[index].isFav! == "true"
                            ? true
                            : false,
                        title: radiodata.allMusicItems[index].name!,
                        subtitle: radiodata.allMusicItems[index].type!,
                        image: radiodata.allMusicItems[index].imageUrl!,
                        ontap: () {
                          radiodata.changeBar(radiodata.allMusicItems[index]);
                        },
                      );
                    }),
                separatorBuilder: (context, index) => SizedBox(height: 10),
                itemCount:
                    Provider.of<DataProvider>(context).allMusicItems.length),
          ),
          InkWell(
            onTap: () {
              setState(() {
                DataProvider.playPauseIcon =
                    DataProvider.playPauseIcon == Icons.play_arrow
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
          ),
        ],
      )
    );
  }
}
