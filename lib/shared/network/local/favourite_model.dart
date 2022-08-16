const String tableFavourite = 'favourite';

class LocalFavouriteModelFields {
  static final List<String> values = [
    /// Add all fields
    itemId,
    name,
    type,
    imageUrl,
    soundUrl,
    isFav,
  ];

  static const String itemId = 'ITEM_ID';
  static const String name = 'NAME';
  static const String type = 'TYPE';
  static const String imageUrl = 'IMAGE_URL';
  static const String soundUrl = 'SOUND_URL';
  static const String isFav = 'ISFAV';
}

class FavouriteModel {
  int? id;
  String? name;
  String? type;
  String? imageUrl;
  String? soundUrl;
  String? isFav;

  FavouriteModel({
    this.id,
    this.name,
    this.type,
    this.imageUrl,
    this.soundUrl,
    this.isFav,
  });

  FavouriteModel.fromJson(dynamic json) {
    id = json['ITEM_ID'];
    name = json['NAME'];
    type = json['TYPE'];
    imageUrl = json['IMAGE_URL'];
    soundUrl = json['SOUND_URL'];
    isFav = json['ISFAV'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ITEM_ID'] = id;
    map['NAME'] = name;
    map['TYPE'] = type;
    map['IMAGE_URL'] = imageUrl;
    map['SOUND_URL'] = soundUrl;
    map['ISFAV'] = isFav;
    return map;
  }
}
