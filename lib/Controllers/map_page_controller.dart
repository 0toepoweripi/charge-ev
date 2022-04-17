import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPageController extends ChangeNotifier {
  Completer<GoogleMapController> controller = Completer();
}
