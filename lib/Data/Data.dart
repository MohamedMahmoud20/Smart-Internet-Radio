// ignore_for_file: avoid_print, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio/Controller/Provider.dart';

class RadioData {
  final int id;
  final String name;
  final String type;
  final String imageUrl;
  final String soundUrl;

  RadioData(
      {required this.id,
      required this.name,
      required this.type,
      required this.imageUrl,
      required this.soundUrl});
}

final homeRadiosJson = [
  {
    'id': 1,
    'name': 'Tarateel',
    'type': 'Quran',
    'imageUrl':
        'lib/images/tarateel.png',
    'soundurl': 'https://Qurango.net/radio/tarateel'
  },
  {
    'id': 2,
    'name': '9090 FM ',
    'type': 'Sports',
    'imageUrl':
        'lib/images/9090.png',
    'soundurl': 'https://9090streaming.mobtada.com/9090FMEGYPT'
  },
  {
    'id': 3,
    'name': 'Quran',
    'type': 'Quran',
    'imageUrl':
        'lib/images/quraan.png',
    'soundurl': 'https://Qurango.net/radio/mohammad_altablaway'
  },
  {
    'id': 4,
    'name': '90s Fm',
    'type': 'News',
    'imageUrl':
        'lib/images/90s.png',
    'soundurl': 'https://eu1.fastcast4u.com/proxy/prontofm?mp=/1'
  },
  {
    'id': 5,
    'name': 'Mahatet masr',
    'type': 'news',
    'imageUrl':
        'lib/images/محطه مصر.png',
    'soundurl': 'https://s3.radio.co/s9cb11828c/listen'
  },
  {
    'id': 6,
    'name': 'Nagham FM',
    'type': 'music',
    'imageUrl':
        'lib/images/nagham fm.jpg',
    'soundurl': 'https://ahmsamir.radioca.st/stream'
  },
  {
    'id': 7,
    'name': 'MIX FM',
    'type': 'Music',
    'imageUrl':
        'lib/images/mix fm.png',
    'soundurl': 'https://c34.radioboss.fm:18035/stream'
  },
  {
    'id': 8,
    'name': 'Mega',
    'type': 'music',
    'imageUrl':
        'lib/images/mega fm.png',
    'soundurl': 'https://audiostreaming.twesto.com/megafm214'
  },
  {
    'id': 9,
    'name': 'Sha3by fm',
    'type': 'Music',
    'imageUrl':
        'lib/images/sha3bi.jpg',
    'soundurl': 'https://radio95.radioca.st/stream/1/'
  },
  {
    'id': 10,
    'name': 'Eza3et Al-ahram',
    'type': 'News',
    'imageUrl':
        'lib/images/alahram.jpg',
    'soundurl': 'https://radiostream.ahram.org.eg/stream'
  },
  {
    'id': 11,
    'name': 'Elkhalas',
    'type': 'Music',
    'imageUrl':
        'lib/images/radio.webp',
    'soundurl': 'https://i7.streams.ovh/sc/hoperad2/stream'
  },
  {
    'id': 12,
    'name': 'Radio masr',
    'type': 'News',
    'imageUrl':
        'lib/images/radio masr.jpg',
    'soundurl': 'https://live.radiomasr.net/RADIOMASR'
  },
  {
    'id': 13,
    'name': 'Energy Fm',
    'type': 'music',
    'imageUrl':
        'lib/images/nrj.png',
    'soundurl': 'https://nrjstreaming.ahmed-melege.com/nrjegypt'
  },
  {
        'id': 14,
        'name': 'BBC arabic',
        'type': 'news',
        'imageUrl': 'lib/images/bbc.png',
        'soundurl': 'https://stream.live.vc.bbcmedia.co.uk/bbc_arabic_radio'
  },
  {
    'id': 15,
    'name': 'Sky news',
    'type': 'news',
    'imageUrl': 'lib/images/sky.jpg',
    'soundurl': 'https://radio.skynewsarabia.com/stream/radio/skynewsarabia'
  }
];

Widget radioStation(
        {
          required int index,
        required VoidCallback onTap,
        required double height,
        var name,
        var type,
        var image,
        var ICON,
        var onpress,
        }
        ) =>
Consumer<DataProvider>(builder: (BuildContext context, value, Widget? child) {
  return  ListTile(
    onTap: onTap,
    title: Text(
      "$name",
      style: const TextStyle(fontSize: 20),
    ),
    subtitle: Text("$type"),
    leading: ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image(
        image: AssetImage("$image"),
        width: height / 10,
        fit: BoxFit.cover,
      ),
    ),
    trailing: IconButton(
        onPressed: onpress,
        icon:  Icon(ICON)),
  );
}
,);


  final homeRadios = <RadioData>[
    RadioData(
        id: 1,
        name: 'Tarateel',
        type: 'Quran',
        imageUrl:
        'lib/images/tarateel.png',
        soundUrl: 'https://Qurango.net/radio/tarateel'),
    RadioData(
        id: 2,
        name: '9090 FM ',
        type: 'Sports',
        imageUrl:
        'lib/images/9090.png',
        soundUrl: 'https://9090streaming.mobtada.com/9090FMEGYPT'),
    RadioData(
        id: 3,
        name: ' Quaran',
        type: 'Quran',
        imageUrl:
        'lib/images/quraan.png',
        soundUrl: 'https://Qurango.net/radio/mohammad_altablaway'),
    RadioData(
        id: 4,
        name: '90s Fm',
        type: 'News',
        imageUrl:
        'lib/images/90s.png',
        soundUrl: 'https://eu1.fastcast4u.com/proxy/prontofm?mp=/1'),
    RadioData(
        id: 5,
        name: 'Mahatet masr',
        type: 'news',
        imageUrl:
        'lib/images/محطه مصر.png',
        soundUrl: 'https://s3.radio.co/s9cb11828c/listen'),
    RadioData(
        id: 6,
        name: 'Nagham FM',
        type: 'music',
        imageUrl:
        'lib/images/nagham fm.jpg',
        soundUrl: 'https://ahmsamir.radioca.st/stream'),
    RadioData(
        id: 7,
        name: 'MIX FM',
        type: 'Music',
        imageUrl:
        'lib/images/mix fm.png',
        soundUrl: 'https://c34.radioboss.fm:18035/stream'),
    RadioData(
        id: 8,
        name: 'Mega',
        type: 'msuic',
        imageUrl:
        'lib/images/mega fm.png',
        soundUrl: 'https://audiostreaming.twesto.com/megafm214'),
    RadioData(
        id: 9,
        name: 'Sha3by fm',
        type: 'Music',
        imageUrl:
        'lib/images/sha3bi.jpg',
        soundUrl: 'https://radio95.radioca.st/stream/1/'),
    RadioData(
        id: 10,
        name: 'Eza3et Al-ahram',
        type: 'News',
        imageUrl:
        'lib/images/alahram.jpg',
        soundUrl: 'https://radiostream.ahram.org.eg/stream'),
    RadioData(
        id: 11,
        name: 'Elkhalas',
        type: 'Music',
        imageUrl:
        'lib/images/radio.webp',
        soundUrl: 'https://i7.streams.ovh/sc/hoperad2/stream'),
    RadioData(
        id: 12,
        name: 'Radio masr',
        type: 'News',
        imageUrl:
        'lib/images/radio masr.jpg',
        soundUrl: 'https://live.radiomasr.net/RADIOMASR'),
    RadioData(
        id: 13,
        name: 'Energy Fm',
        type: 'music',
        imageUrl:
        'lib/images/nrj.png',
        soundUrl: 'https://nrjstreaming.ahmed-melege.com/nrjegypt'),
    RadioData(
        id: 14,
        name: 'BBC arabic',
        type: 'news',
        imageUrl:
        'lib/images/bbc.png',
        soundUrl: 'https://stream.live.vc.bbcmedia.co.uk/bbc_arabic_radio'),
    RadioData(
        id: 15,
        name: 'Sky news',
        type: 'news',
        imageUrl:
        'lib/images/sky.jpg',
        soundUrl: 'https://radio.skynewsarabia.com/stream/radio/skynewsarabia')
  ];

