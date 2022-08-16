// ignore_for_file: non_constant_identifier_names, avoid_types_as_parameter_names, avoid_print, file_names, prefer_const_constructors

import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio/Controller/Provider.dart';
import '../shared/network/local/favourite_model.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  IconData favIcon = Icons.favorite_border;
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    Provider.of<DataProvider>(context, listen: false).setupAlan();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // DataProvider provider = DataProvider.get(context);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Consumer<DataProvider>(
                builder: (context, radiodata, Widget? child) {
                  return ListView.separated(
                      itemBuilder: (context, index) => radiolistile(
                        isfav: radiodata.allItems[index].isFav == "true" ? true : false,
                        title: radiodata.allItems[index].name!,
                        subtitle: radiodata.allItems[index].type!,
                        image: radiodata.allItems[index].imageUrl!,
                        checkfavorite: () async {
                          FavouriteModel model = FavouriteModel(
                            id: radiodata.allItems[index].id,
                            name: radiodata.allItems[index].name,
                            type: radiodata.allItems[index].type,
                            imageUrl: radiodata.allItems[index].imageUrl,
                            soundUrl: radiodata.allItems[index].soundUrl,
                            isFav: radiodata.allItems[index].isFav! == "true" ? "false" : "true",
                          );
                          await radiodata.toggleFavIcon(
                            favouriteModel: model,
                          );
                        },
                        ontap: () {
                            DataProvider.index=index;
                            DataProvider.title = radiodata.allItems[index].name!;
                            DataProvider.category = radiodata.allItems[index].type!;
                            DataProvider.image = radiodata.allItems[index].imageUrl!;
                            DataProvider.soundUrl = radiodata.allItems[index].soundUrl!;
                            DataProvider.playPauseIcon = Icons.pause;
                            DataProvider.id = radiodata.allItems[index].id!;
                            Provider.of<DataProvider>(context, listen: false)
                                .getAudio(DataProvider.soundUrl);
                          // log("Index = = ${DataProvider.index}");
                        },
                      ),
                      itemCount: radiodata.allItems.length,
                      separatorBuilder: (context, index) => SizedBox(height: 10));
                },
            ),
          ),
        ],
      ),
    );
  }
}