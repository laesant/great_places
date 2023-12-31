import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/models/place.dart';
import 'package:great_places/utils/db_util.dart';
import 'package:great_places/utils/location_util.dart';

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
            location: PlaceLocation(
                latitude: item['lat'],
                longitude: item['lng'],
                address: item['address']),
            image: File(item['image'])))
        .toList();
    notifyListeners();
  }

  Place itemByIndex(int index) => _items[index];

  Future<void> addPlace({
    required String title,
    required File image,
    required LatLng position,
  }) async {
    String address = await LocationUtil.getAddressFrom(position);

    final Place newPlace = Place(
        id: Random().nextDouble().toString(),
        title: title,
        location: PlaceLocation(
            latitude: position.latitude,
            longitude: position.longitude,
            address: address),
        image: image);

    _items.add(newPlace);
    DbUtil.insert('places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'lat': position.latitude,
      'lng': position.longitude,
      'address': address
    });
    notifyListeners();
  }
}
