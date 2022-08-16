// ignore_for_file: non_constant_identifier_names, file_names, avoid_print, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio/Controller/Provider.dart';

class Fav extends StatefulWidget {
  const Fav({Key? key}) : super(key: key);

  @override
  State<Fav> createState() => _FavState();
}

class _FavState extends State<Fav> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Consumer<DataProvider>(
        builder: (BuildContext context, dataProvider, child) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: dataProvider.favItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      margin: EdgeInsets.all(5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: SizedBox(
                        height: size.height / 10,
                        child: ListTile(
                          onTap: () {
                            DataProvider.title =
                                dataProvider.favItems[index].name!;
                            DataProvider.category =
                                dataProvider.favItems[index].type!;
                            DataProvider.image =
                                dataProvider.favItems[index].imageUrl!;
                            DataProvider.soundUrl =
                                dataProvider.favItems[index].soundUrl!;
                            DataProvider.playPauseIcon = Icons.pause;
                            DataProvider.id = dataProvider.favItems[index].id!;
                            Provider.of<DataProvider>(context, listen: false)
                                .getAudio(
                                    dataProvider.favItems[index].soundUrl);
                          },
                          title: Text(
                            "${dataProvider.favItems[index].name}",
                            style: TextStyle(fontSize: 20),
                          ),
                          subtitle:
                              Text("${dataProvider.favItems[index].type}"),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image(
                              image: AssetImage(
                                "${dataProvider.favItems[index].imageUrl}",
                              ),
                              width: size.height / 10,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
