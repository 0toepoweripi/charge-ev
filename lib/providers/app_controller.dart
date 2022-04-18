import 'dart:developer';
import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:charge_ev/Models/charging_station.dart';
import 'package:charge_ev/services/charging_stations_service.dart';
import 'package:charge_ev/services/device_location_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AppController extends ChangeNotifier {
// data
  int? _carouselPage;
  LatLng? _targetLocation;
  final CameraPosition initialCameraPosition = const CameraPosition(target: LatLng(18.5204, 73.8567), zoom: 4.4746);
  Set<Marker> markers = {};
  List<ChargingStation> chargingStations = [];

// controllers
  final CarouselController carouselController = CarouselController();
  Completer<GoogleMapController> googleMapController = Completer();

// methods
  void onCarouselPageChanged(int index, CarouselPageChangedReason reason) {
    _carouselPage = index;
    LatLng newLocation = LatLng(chargingStations[_carouselPage!].latitude, chargingStations[_carouselPage!].longitude);
    changeMapCameraPosition(newLocation);
    log('onCarouselPageChanged: $index');
  }

  void changeMapCameraPosition(LatLng position) {
    googleMapController.future.then((controller) {
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: position, zoom: 15.0),
        ),
      );
    });
  }

// controller methods
  Future<bool> initialise() async {
    try {
      log("App controller initialse");
      _targetLocation = await DeviceLocationService().determinePosition();
      fetchChargingStations(_targetLocation!);
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  void fetchChargingStations(LatLng location) async {
    chargingStations = await ChargingStationsService().getNearbyChargingStations(location);
    if (chargingStations.isNotEmpty) {
      changeMapCameraPosition(LatLng(chargingStations[0].latitude, chargingStations[0].longitude));
      addMarkers(stations: chargingStations);
    }
  }

  void addMarkers({required List<ChargingStation> stations}) {
    markers.clear();
    for (ChargingStation station in stations) {
      markers.add(Marker(
        markerId: MarkerId(station.id),
        position: LatLng(station.latitude, station.longitude),
        infoWindow: InfoWindow(
          title: station.name,
          snippet: station.geohash,
        ),
      ));
    }
    notifyListeners();
  }
}
