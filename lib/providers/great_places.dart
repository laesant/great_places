import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:great_places/models/place.dart';
import 'package:great_places/utils/db_util.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items => [..._items];

  int get itemsCount => _items.length;

  Future<void> loadPlaces() async {
    final dataList = await DbUtil.getData('places');
    _items = dataList
        .map((item) => Place(
            id: item['id'],
            title: item['title'],
            location: PlaceLocation(latitude: 0, longitude: 0),
            image: File(item['image'])))
        .toList();
    notifyListeners();
  }

  Place itemByIndex(int index) => _items[index];

  void addPlace({required String title, required File image}) {
    final Place newPlace = Place(
        id: Random().nextDouble().toString(),
        title: title,
        location: PlaceLocation(latitude: 0, longitude: 0, address: ''),
        image: image);

    _items.add(newPlace);
    DbUtil.insert('places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
    });
    notifyListeners();
  }
}
