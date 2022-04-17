import 'package:charge_ev/Controllers/map_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

import 'package:provider/provider.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late final MapPageController mapPageController;

  @override
  void initState() {
    mapPageController = MapPageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, controller, _) => Scaffold(
        appBar: AppBar(
          title: const Text('Charge EV'),
        ),
        body: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: MapPage._kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            mapPageController.controller.complete(controller);
          },
        ),
      ),
    );
  }
}
