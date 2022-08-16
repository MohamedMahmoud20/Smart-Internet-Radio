// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables,, camel_case_types use_key_in_widget_constructors, file_names, camel_case_types, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Search screen.dart';
import 'favorite screen.dart';
import 'home screen.dart';
import '../drawer.dart';
import 'package:radio/Controller/Provider.dart';

class home_screen extends StatefulWidget {
  @override
  _home_screenState createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Consumer<DataProvider>(
      builder: (context, dataProvider, child) => DefaultTabController(
        length: 2,
        child: Scaffold(
          extendBodyBehindAppBar: true,
          drawer: Drawer(
            child: Column(
              children: [Header(), Categories()],
            ),
          ),
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Radio app',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('lib/images/appbar.jpg'),
                    fit: BoxFit.cover),
              ),
            ),
            elevation: 0,
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => searchsc()));
                },
              )
            ],
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.home),
                  child: Text('home'),
                ),
                Tab(
                  icon: Icon(Icons.favorite),
                  child: Text('favorites'),
                ),
              ],
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: TabBarView(
                  children: [
                    HomeScreen(), //home screen
                    Fav() //favorites screen
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  DataProvider.playPauseIcon =
                      DataProvider.playPauseIcon == Icons.play_arrow
                          ? Icons.pause
                          : Icons.play_arrow;

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
          ),
          drawerEnableOpenDragGesture: true,
        ),
      ),
    );
  }
}
