import 'package:cloud_firestore/cloud_firestore.dart';

class ChargingStation {
  ChargingStation(
      {required this.id,
      required this.images,
      required this.name,
      required this.displayImage,
      required this.geohash,
      required this.latitude,
      required this.longitude});

  String id;
  List<String> images;
  String name;
  String displayImage;
  String geohash;
  double latitude;
  double longitude;

  factory ChargingStation.fromJson(Map<String, dynamic> json) =>
      ChargingStation(
          id: json["id"],
          images: List<String>.from(json["images"].map((x) => x)),
          name: json["name"],
          displayImage: json["display_image"],
          geohash: json['geohash'],
          latitude: json['latitude'],
          longitude: json['longitude']);
  Map<String, dynamic> toJson() => {
        "id": id,
        "images": List<dynamic>.from(images.map((x) => x)),
        "name": name,
        "display_image": displayImage,
        "geohash": geohash,
        "latitude": latitude,
        "longitude": longitude,
      };

  factory ChargingStation.fromDocumentSnapshot(
          QueryDocumentSnapshot snapshot) =>
      ChargingStation(
        id: snapshot.id,
        images: List<String>.from(snapshot.get('images')),
        name: snapshot.get('name'),
        displayImage: snapshot.get('display_image'),
        geohash: snapshot.get('position')['geohash'],
        latitude: snapshot.get('position')['geopoint'].latitude,
        longitude: snapshot.get('position')['geopoint'].longitude,
      );
}
