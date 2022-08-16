import 'dart:developer';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio/shared/network/local/favourite_model.dart';
import 'package:radio/shared/network/local/local_db.dart';
import '../Data/Data.dart';
import 'SQFlite.dart';
import 'package:alan_voice/alan_voice.dart';


class DataProvider with ChangeNotifier {

  static DataProvider get(BuildContext context) => Provider.of<DataProvider>(context, listen: false);

  late List<RadioData> searchradios;
  static int index = 0;
  static String title = homeRadios[0].name;
  static String category = homeRadios[0].type;
  static int id = homeRadios[0].id;
  static String soundUrl = homeRadios[0].soundUrl;
  static String image = homeRadios[0].imageUrl;
  static IconData playPauseIcon = Icons.play_arrow;
  static IconData favIcon = Icons.favorite_border;


  changeBar(FavouriteModel favouriteModel) async{
    DataProvider.title = favouriteModel.name!;
    DataProvider.category = favouriteModel.type!;
    DataProvider.image = favouriteModel.imageUrl!;
    DataProvider.soundUrl = favouriteModel.soundUrl!;
    DataProvider.playPauseIcon = Icons.pause;
    DataProvider.id = favouriteModel.id!;
    getAudio(favouriteModel.soundUrl!);
    notifyListeners();
  }

  void currentChannel (int indx){
      DataProvider.index = indx;
      DataProvider.title = homeRadios[DataProvider.index].name;
      DataProvider.category = homeRadios[DataProvider.index].type;
      DataProvider.image = homeRadios[DataProvider.index].imageUrl;
      DataProvider.soundUrl = homeRadios[DataProvider.index].soundUrl;
      DataProvider.playPauseIcon = Icons.pause;
      DataProvider.id = homeRadios[DataProvider.index].id;

      getAudio(DataProvider.soundUrl);

      notifyListeners();
  }

  void setupAlan(){
    AlanVoice.addButton(
        "5a1f2b34d4b1d69620e6b6972cca03b42e956eca572e1d8b807a3e2338fdd0dc/stage",
        buttonAlign: AlanVoice.BUTTON_ALIGN_RIGHT
    );

    void _handleCommand(Map<String, dynamic> response){
      debugPrint("command was ${response.toString()}");
      switch(response["command"].toString().toLowerCase()){
        case 'play':
          // Provider.of<DataProvider>(context, listen: false).
          getAudio(DataProvider.soundUrl);
          // setState(() {
          DataProvider.playPauseIcon = Icons.pause;
          // });
          break;
        case 'pause':
          pause();
          DataProvider.playPauseIcon = Icons.play_arrow;
          break;
        case 'play_channel':
          pause();
          DataProvider.index = response['id'] - 1;
          currentChannel(DataProvider.index);
          break;
        case 'favorite':
          toggleFavIcon(favouriteModel:   FavouriteModel(
            id:  allItems[DataProvider.index].id,
            name:  allItems[DataProvider.index].name,
            type:  allItems[DataProvider.index].type,
            imageUrl:  allItems[DataProvider.index].imageUrl,
            soundUrl:  allItems[DataProvider.index].soundUrl,
            isFav:  allItems[DataProvider.index].isFav! == "true" ? "false" : "true",
          ));
          break;
        case 'favorite_channel':
          DataProvider.index = response['id'] - 1;
          toggleFavIcon(favouriteModel:   FavouriteModel(
            id:  allItems[DataProvider.index].id,
            name:  allItems[DataProvider.index].name,
            type:  allItems[DataProvider.index].type,
            imageUrl:  allItems[DataProvider.index].imageUrl,
            soundUrl:  allItems[DataProvider.index].soundUrl,
            isFav:  allItems[response['id'] - 1].isFav! == "true" ? "false" : "true",
          ));
          break;
        case 'next':
          DataProvider.index++;
          if(DataProvider.index == 15)
            DataProvider.index = 0;
          pause();
          currentChannel(DataProvider.index);
          break;
        case 'previous':
          DataProvider.index--;
          if(DataProvider.index == -1)
            DataProvider.index = 14;
          pause();
          currentChannel(DataProvider.index);
          break;
        case 'category':
          pause();
          DataProvider.index = response['id'] - 1;
          currentChannel(DataProvider.index);
          break;
      }

      notifyListeners();
    }

    AlanVoice.onCommand.add((command) => _handleCommand(command.data));
  }

/////////////////////////////////////////////////////////////////////audioplayers

  AudioPlayer audioPlayer = AudioPlayer();
  Duration duration = const Duration();
  Duration position = const Duration();
  var IIcon = Icons.play_arrow;
  bool playing = false;

  dynamic onpress(Url) {
    IIcon = IIcon == Icons.play_arrow ? Icons.pause : Icons.play_arrow;
    notifyListeners();
    getAudio2(Url);
    notifyListeners();
  }

  getAudio(Url) async {
    var url = Url;

    if (playing) {
      var res = await audioPlayer.play(url, isLocal: true);
      if (res == 1) {
        playing = true;
        notifyListeners();
      }
    } else {
      var res = await audioPlayer.play(url, isLocal: true);
      if (res == 1) {
        playing = true;
        notifyListeners();
      }
    }
    audioPlayer.onDurationChanged.listen((Duration dd) {
      duration = dd;
    });
    audioPlayer.onAudioPositionChanged.listen((Duration dd) {
      position = dd;
      notifyListeners();
    });

    notifyListeners();
  }

  getAudio2(Url) async {
    var url = Url;
    if (playing) {
      var res = await audioPlayer.pause();
      if (res == 1) {
        playing = false;
        notifyListeners();
      }
    } else {
      var res = await audioPlayer.play(url, isLocal: true);
      if (res == 1) {
        playing = true;
        notifyListeners();
      }
    }
    audioPlayer.onDurationChanged.listen((Duration dd) {
      duration = dd;
    });
    audioPlayer.onAudioPositionChanged.listen((Duration dd) {
      position = dd;
      notifyListeners();
    });


    notifyListeners();
  }

  pause() {
    audioPlayer.stop();
  }

///////////////////////////////////////////////////////////////////////////lists of radios
  List favolist = [];
  List<FavouriteModel> musicradio = [];
  List<FavouriteModel> newsradio = [];
  List<FavouriteModel> quraanradio = [];
  List<FavouriteModel> sportradio = [];

  // musicradio = allItems
  //     .where((element) => (element.type!.toLowerCase().contains('music')))
  //     .toList();
  // newsradio = allItems
  //     .where((element) => (element.type!.toLowerCase().contains('news')))
  //     .toList();
  //  quraanradio = allItems
  //     .where((element) => (element.type!.toLowerCase().contains('quraan')))
  //     .toList();
  // sportradio = allItems
  //     .where((element) => (element.type!.toLowerCase().contains('sports')))
  //     .toList();


  final homeRadiosData = <FavouriteModel>[
    FavouriteModel(
      id: 1,
      isFav: "false",
      name: 'Tarateel',
      type: 'quraan',
      imageUrl:
          'lib/images/tarateel.png',
      soundUrl: 'https://Qurango.net/radio/tarateel',
    ),
    FavouriteModel(
        id: 2,
        isFav: "false",
        name: '9090 FM ',
        type: 'Sports',
        imageUrl: 'lib/images/9090.png',
        soundUrl: 'https://9090streaming.mobtada.com/9090FMEGYPT'),
    FavouriteModel(
        id: 3,
        isFav: "false",
        name: 'Quaran',
        type: 'quraan',
        imageUrl:
            'lib/images/quraan.png',
        soundUrl: 'https://Qurango.net/radio/mohammad_altablaway'),
    FavouriteModel(
        id: 4,
        isFav: "false",
        name: '90s Fm',
        type: 'News',
        imageUrl:
            'lib/images/90s.png',
        soundUrl: 'https://eu1.fastcast4u.com/proxy/prontofm?mp=/1'),
    FavouriteModel(
        id: 5,
        isFav: "false",
        name: 'Mahatet masr',
        type: 'News',
        imageUrl:
            'lib/images/محطه مصر.png',
        soundUrl: 'https://s3.radio.co/s9cb11828c/listen'),
    FavouriteModel(
        id: 6,
        isFav: "false",
        name: 'Nagham FM',
        type: 'music',
        imageUrl:
            'lib/images/nagham fm.jpg',
        soundUrl: 'https://ahmsamir.radioca.st/stream'),
    FavouriteModel(
        id: 7,
        isFav: "false",
        name: 'MIX FM',
        type: 'music',
        imageUrl:
        'lib/images/mix fm.png',
        soundUrl: 'https://c34.radioboss.fm:18035/stream'),
    FavouriteModel(
        id: 8,
        isFav: "false",
        name: 'Mega',
        type: 'music',
        imageUrl:
            'lib/images/mega fm.png',
        soundUrl: 'https://audiostreaming.twesto.com/megafm214'),
    FavouriteModel(
        id: 9,
        isFav: "false",
        name: 'Sha3by fm',
        type: 'music',
        imageUrl:
            'lib/images/sha3bi.jpg',
        soundUrl: 'https://radio95.radioca.st/stream/1/'),
    FavouriteModel(
        id: 10,
        isFav: "false",
        name: 'Eza3et Al-ahram',
        type: 'News',
        imageUrl:
            'lib/images/alahram.jpg',
        soundUrl: 'https://radiostream.ahram.org.eg/stream'),
    FavouriteModel(
        id: 11,
        isFav: "false",
        name: 'Elkhalas',
        type: 'News',
        imageUrl:
            'lib/images/radio.webp',
        soundUrl: 'https://i7.streams.ovh/sc/hoperad2/stream'),
    FavouriteModel(
        id: 12,
        isFav: "false",
        name: 'Radio masr',
        type: 'News',
        imageUrl:
            'lib/images/radio masr.jpg',
        soundUrl: 'https://live.radiomasr.net/RADIOMASR'),
    FavouriteModel(
        id: 13,
        isFav: "false",
        name: 'Energy Fm',
        type: 'music',
        imageUrl:
            'lib/images/nrj.png',
        soundUrl: 'https://nrjstreaming.ahmed-melege.com/nrjegypt'),
    FavouriteModel(
        id: 14,
        isFav: "false",
        name: 'BBC arabic',
        type: 'News',
        imageUrl: 'lib/images/bbc.png',
        soundUrl: 'https://stream.live.vc.bbcmedia.co.uk/bbc_arabic_radio'),
    FavouriteModel(
        id: 15,
        isFav: "false",
        name: 'Sky news',
        type: 'News',
        imageUrl:
            'lib/images/sky.jpg',
        soundUrl: 'https://radio.skynewsarabia.com/stream/radio/skynewsarabia'),
  ];

  ////////////////////////////////////////////////function of radio(favorite)
  // void fav(int index) {
  //   homeRadiosData[index].favorite(
  //     homeRadiosData[index].name,
  //     homeRadiosData[index].soundUrl,
  //     homeRadiosData[index].imageUrl,
  //     homeRadiosData[index].type,
  //     homeRadiosData[index].id,
  //     homeRadiosData[index].isFav,
  //   );
  //   notifyListeners();
  // }


  toggleFavIcon(
      {required  FavouriteModel favouriteModel}) async {
    log('toggleFavIcon');
    log('Index = $index');

    await update(favouriteModel: favouriteModel).then((value) async {
      allMusicItems = [];
      allNewsItems= [];
      allQuranItems=[];
      allSportsItems= [];

      await  getAllMusicItems();
      await getAllNewsItems();
      await getAllQuranItems();
      await getAllSportsItems();

       // musicradio = allItems
       //    .where((element) => (element.type!.toLowerCase().contains('music')))
       //    .toList();
       // newsradio = allItems
       //    .where((element) => (element.type!.toLowerCase().contains('news')))
       //    .toList();
       // quraanradio = allItems
       //    .where((element) => (element.type!.toLowerCase().contains('quraan')))
       //    .toList();
       // sportradio = allItems
       //    .where((element) => (element.type!.toLowerCase().contains('sports')))
       //    .toList();
    });

    log('isFav: ${favouriteModel.isFav}');
    notifyListeners();

    // if (isFav) {
    //   isFav = !isFav;
    //   await delete(favouriteModel: favouriteModel);
    // } else {
    //   isFav = !isFav;
    //   await insertItem(favouriteModel: favouriteModel);
    // }
  }

  final db = LocalDB.instance;

  Future<void> saveAllData() async{
    log('saveAllData');
    // if(allItems.isEmpty) {
    for(var item in homeRadiosData) {
      await insertItem(favouriteModel: item);
    }
    //   homeRadiosData.map((element) async{
    //   await insertItem(favouriteModel: element);
    // });
    // }else{
    //   log('----- Data already saved -----');
    // }

  }

  Future<void> insertItem({required FavouriteModel favouriteModel}) async {
    await db.saveItemData(favouriteModel: favouriteModel).then((value) async {
      await getFavItems();
    });
    notifyListeners();
  }

  List<FavouriteModel> favItems = [];
  List<FavouriteModel> allItems = [];
  List<FavouriteModel> allMusicItems = [];
  List<FavouriteModel> allNewsItems = [];
  List<FavouriteModel> allQuranItems = [];
  List<FavouriteModel> allSportsItems = [];
  FavouriteModel? favSingleItem;

  Future<void> getAllItems() async {
    log('getAllItems');
    allItems = [];
    allItems = await db.getItemsData();
    if(allItems.isEmpty){
      await saveAllData();
    }
    log('getAllItems: ${allItems.length}');
    notifyListeners();
  }

  Future<void> getAllMusicItems() async {
    log('getAllMusicItems');
    allMusicItems = [];
    List<FavouriteModel> myList = await db.getItemsData();

    allMusicItems = myList.where((element) => element.type == "music").toList();

    log('getAllMusicItems: ${allMusicItems.length}');
    notifyListeners();
  }

  Future<void> getAllNewsItems() async {
    log('getAllMusicItems');
    allNewsItems = [];
    List<FavouriteModel> myList = await db.getItemsData();

    allNewsItems = myList.where((element) => element.type == "News").toList();

    log('allNewsItems: ${allNewsItems.length}');
    notifyListeners();
  }

  Future<void> getAllQuranItems() async {
    log('getAllQuranItems');
    allQuranItems = [];
    List<FavouriteModel> myList = await db.getItemsData();

    allQuranItems = myList.where((element) => element.type == "quraan").toList();

    log('allQuranItems: ${allQuranItems.length}');
    notifyListeners();
  }

  Future<void> getAllSportsItems() async {
    log('getAllSportsItems');
    allSportsItems = [];
    List<FavouriteModel> myList = await db.getItemsData();

    allSportsItems = myList.where((element) => element.type == "Sports").toList();

    log('allSportsItems: ${allSportsItems.length}');
    notifyListeners();
  }

  Future<void> getFavItems() async {
    log('getFavItems');
    favItems = [];
    List<FavouriteModel> allItems = await db.getItemsData();
    favItems = allItems.where((element) => element.isFav == "true").toList();
    log('getFavItems: ${favItems.length}');
    notifyListeners();
  }

  Future<void> getSingleItem({required int itemId}) async {
    favSingleItem = await db.getSingleItemData(itemId: itemId);
    notifyListeners();
  }

  Future<int> update({required FavouriteModel favouriteModel}) async {
    int success = await db.updateItemData(favouriteModel: favouriteModel);
    log('success: $success');
    log('isFav: ${favouriteModel.isFav}');
    await getAllItems();
    notifyListeners();
    await getFavItems();
    notifyListeners();
    return success;
  }

  Future<void> delete({required FavouriteModel favouriteModel}) async {
    await db.deleteItemData(favouriteModel: favouriteModel).then((value) async {
      await getFavItems();
      notifyListeners();
    });
  }
}

class radiodata {
  SQFLITE SQL = SQFLITE();
  final int id;
  final String name;
  final String type;
  final String imageUrl;
  final String soundUrl;
  bool isfav = false;

  radiodata({
    required this.id,
    required this.name,
    required this.type,
    required this.imageUrl,
    required this.soundUrl,
  });

  void favorite(name, sound, image, type , id , isFav) async {
    if (isfav) {
      isfav = !isfav;
      // int res = await SQL.Delete(
      //     "DELETE FROM 'Todo' WHERE id = ${fav[index]['id']}");
    } else {
      isfav = !isfav;
      await SQL.Insert(
          '''INSERT INTO Todo ('title' , 'url' , 'image' , 'subtitle')
            VALUES("$name" , "$sound" , "$image" , "$type" )
                                ''');
    }
  }
}


class radiolistile extends StatelessWidget {
  final bool isfav;
  String title, subtitle, image;
  final VoidCallback checkfavorite;
  final VoidCallback ontap;

  radiolistile({
    Key? key,
    required this.checkfavorite,
    required this.isfav,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.ontap,
    // required this.index,
    //  required this.channal
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: ontap,
        title: Text(
          title,
          style: TextStyle(fontSize: 20),
        ),
        subtitle: Text(subtitle),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image(
            image: AssetImage(image),
            height: 60,
            width: 60,
            fit: BoxFit.cover,
          ),
        ),
        trailing: Consumer<DataProvider>(
          builder: (BuildContext context, value, Widget? child) {
            return IconButton(
                onPressed: checkfavorite,
                icon:
                    isfav ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
            );
          },
        ),
    );
  }
}