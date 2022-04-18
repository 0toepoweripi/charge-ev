import 'dart:convert';
import 'dart:developer';
import 'package:charge_ev/Models/charging_station.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer' as console;

import 'package:google_maps_flutter/google_maps_flutter.dart';

class ChargingStationsService {
  final geo = Geoflutterfire();
  final _firestore = FirebaseFirestore.instance;

  Future<List<ChargingStation>> getNearbyChargingStations(LatLng location) async {
    GeoFirePoint geoPoint = geo.point(latitude: location.latitude, longitude: location.longitude);
    try {
      // Create a CollectionReference called users that references the firestore collection
      final chargingStationsCollection = _firestore.collection('charging_stations');
      final QuerySnapshot querySnapshot = await chargingStationsCollection.get();
      Stream<List<DocumentSnapshot<Map<String, dynamic>>>> nearestStations = geo
          .collection(
            collectionRef: chargingStationsCollection,
          )
          .within(
            center: geoPoint,
            radius: 10,
            field: "position",
          );
      log("nearest locations: ${nearestStations.toString()}");
      List<ChargingStation> stations = querySnapshot.docs
          .map(
            (e) => ChargingStation.fromDocumentSnapshot(e),
          )
          .toList();
      return stations;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> createChargingStation() async {
    try {
      GeoFirePoint myLocation = geo.point(latitude: 18.5204, longitude: 73.8567);
      // Create a CollectionReference called users that references the firestore collection
      CollectionReference chargingStationsCollection = _firestore.collection('charging_stations');
      DocumentReference documentReference = await chargingStationsCollection.add({
        'name': 'Charging Station',
        'position': myLocation.data,
        "display_image": "-",
        "images": [],
      });
      console.log(documentReference.id);
    } catch (e) {
      return Future.error(e);
    }
  }
}
