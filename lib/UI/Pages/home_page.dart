import 'package:charge_ev/Controllers/charging_stations_controller.dart';
import 'package:charge_ev/Models/charging_station.dart';
import 'package:charge_ev/UI/Widgets/charging_stations_map_view.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Charge EV"),
      ),
      body: FutureBuilder(
          future: ChargingStationsController().getNearbyChargingStations(),
          builder: (context, AsyncSnapshot<List<ChargingStation>> snapshot) {
            if (snapshot.hasData) {
              return Scaffold(
                body: ChargingStationsMapView(stations: snapshot.data!),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Text("Loading"),
              );
            }
            return const Center(
              child: Text("Could not find any Stations"),
            );
          }),
    );
  }
}
