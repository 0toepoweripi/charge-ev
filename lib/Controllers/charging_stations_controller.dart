import 'dart:convert';
import 'package:charge_ev/Models/charging_station.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer' as console;

class ChargingStationsController {
  final geo = Geoflutterfire();
  final _firestore = FirebaseFirestore.instance;

  Future<List<ChargingStation>> getNearbyChargingStations() async {
    try {
      // Create a CollectionReference called users that references the firestore collection
      CollectionReference chargingStationsCollection =
          FirebaseFirestore.instance.collection('charging_stations');
      final QuerySnapshot querySnapshot =
          await chargingStationsCollection.get();
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
}
