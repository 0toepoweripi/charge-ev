import 'package:charge_ev/UI/Pages/home_page.dart';
import 'package:charge_ev/UI/Widgets/charging_station_card.dart';
import 'package:charge_ev/providers/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListViewPage extends StatelessWidget {
  const ListViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppController>(
      builder: (context, appController, _) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Charging Stations'),
        ),
        body: ListView.builder(
          itemCount: appController.chargingStations.length,
          itemBuilder: (context, index) => ChargingStationCard(
            station: appController.chargingStations[index],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          label: const Text("Map"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          },
          icon: const Icon(Icons.map),
        ),
      ),
    );
  }
}
