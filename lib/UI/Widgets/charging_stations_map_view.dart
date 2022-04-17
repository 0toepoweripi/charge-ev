import 'dart:developer';

import 'package:charge_ev/Models/charging_station.dart';
import 'package:charge_ev/Services/device_location_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class ChargingStationsMapView extends StatelessWidget {
  ChargingStationsMapView({Key? key, required this.stations}) : super(key: key);
  final List<ChargingStation> stations;
  final Completer<GoogleMapController> _controller = Completer();
  Set<Marker> mapLocatios = {};
  CameraPosition cameraPosition = const CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  Future<bool> initialiseMaps() async {
    try {
      log("stations locations" + stations.length.toString());
      for (ChargingStation chargingStation in stations) {
        mapLocatios.add(
          Marker(
            icon: BitmapDescriptor.defaultMarker,
            position:
                LatLng(chargingStation.latitude, chargingStation.longitude),
            markerId: MarkerId(chargingStation.geohash),
          ),
        );
      }
      Position position = await DeviceLocationService().determinePosition();
      cameraPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 16,
      );
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: initialiseMaps(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            log("map locations" + mapLocatios.length.toString());
            return GoogleMap(
              markers: mapLocatios,
              initialCameraPosition: cameraPosition,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container();
        });
  }
}
