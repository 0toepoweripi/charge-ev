import 'package:charge_ev/Models/charging_station.dart';
import 'package:flutter/material.dart';

class ChargingStationCard extends StatelessWidget {
  const ChargingStationCard({Key? key, required this.station}) : super(key: key);
  final ChargingStation station;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        side: BorderSide(
          width: 0.1,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: ListTile(
        leading: station.displayImage.isNotEmpty
            ? CircleAvatar(
                backgroundImage: NetworkImage(station.displayImage),
              )
            : null,
        title: Text(station.name),
        subtitle: Text(station.geohash),
      ),
    );
  }
}
