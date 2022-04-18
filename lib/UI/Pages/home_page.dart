import 'package:carousel_slider/carousel_slider.dart';
import 'package:charge_ev/UI/Pages/list_view_page.dart';
import 'package:charge_ev/UI/Widgets/charging_station_card.dart';
import 'package:charge_ev/providers/app_controller.dart';
import 'package:charge_ev/services/charging_stations_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppController>(
      builder: (context, appController, _) => Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              markers: appController.markers,
              initialCameraPosition: appController.initialCameraPosition,
              zoomControlsEnabled: false,
              myLocationEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                appController.googleMapController.complete(controller);
              },
            ),
          ],
        ),
        bottomSheet: CarouselSlider(
          carouselController: appController.carouselController,
          items: appController.chargingStations.map((e) => ChargingStationCard(station: e)).toList(),
          options: CarouselOptions(
            aspectRatio: 3.0,
            viewportFraction: 0.95,
            enableInfiniteScroll: false,
            enlargeCenterPage: false,
            onPageChanged: appController.onCarouselPageChanged,
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          label: const Text("List"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ListViewPage(),
              ),
            );
          },
          icon: const Icon(Icons.sort),
        ),
      ),
    );
  }
}
