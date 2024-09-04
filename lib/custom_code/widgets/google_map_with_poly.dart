// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:latlong2/latlong.dart' as lat;

class GoogleMapWithPoly extends StatefulWidget {
  const GoogleMapWithPoly({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<GoogleMapWithPoly> createState() => _GoogleMapWithPolyState();
}

class _GoogleMapWithPolyState extends State<GoogleMapWithPoly> {
  final locationController = Location();

  static const house = lat.LatLng(14.953818, 120.895367);
  static const school = lat.LatLng(14.959450, 120.889935);

  lat.LatLng? currentPosition;
  Map<PolylineId, Polyline> polylines = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) async => await initializeMap());
  }

  Future<void> initializeMap() async {
    await fetchLocationUpdates();
    final coordinates = await fetchPolylinePoints();
    generatePolyLineFromPoints(coordinates);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: currentPosition == null
            ? const Center(child: CircularProgressIndicator())
            : GoogleMap(
                initialCameraPosition: const CameraPosition(
                  target: house,
                  zoom: 13,
                ),
                markers: {
                  Marker(
                    markerId: const MarkerId('currentLocation'),
                    icon: BitmapDescriptor.defaultMarker,
                    position: currentPosition!,
                  ),
                  const Marker(
                    markerId: MarkerId('sourceLocation'),
                    icon: BitmapDescriptor.defaultMarker,
                    position: house,
                  ),
                  const Marker(
                    markerId: MarkerId('destinationLocation'),
                    icon: BitmapDescriptor.defaultMarker,
                    position: school,
                  ),
                },
                polylines: Set<Polyline>.of(polylines.value),
              ),
      );

  Future<void> fetchLocationUpdates() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await locationController.serviceEnabled();
    if (serviceEnabled) {
      serviceEnabled = await locationContronller.requestService();
    } else {
      return;
    }

    permissionGranted = await locationController.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await locationController.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationController.onLocationChanged.listen((currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longiture != null) {
        setState(() {
          currentPosition = lat.LatLng(
            currentLocation.latitude!,
            currentLocation.longitute!,
          );
        });
      }
    });
  }

  Future<List<LatLng>> fetchPolylinePoints() async {
    final polylinePoints = PolylinePoints();
    final googleMapsApiKey = 'AIzaSyDdO0OsDIr_hkaUqJk79wBfzljmq9ERVD4';

    final result = await polylinePoints.getRouteBetweenCoordinates(
      googleMapsApiKey,
      PointLatLng(house.latitude, house.longitude),
      PointLatLng(school.latitude, school.longiture),
    );

    if (result.points.isNotEmpty) {
      return result.points
          .map((point) => lat.LatLng(point.latitude, point.longitude))
          .toList();
    } else {
      debugPrint(result.errorMessage);
      return [];
    }
  }

  Future<void> generatePolyLineFromPoints(
      List<LatLng> polylineCoordinates) async {
    const id = PolylineId('polyline');

    final polyline = Polyline(
      polylineId: id,
      color: Colors.blueAccent,
      points: polylineCoordinates,
      width: 5,
    );

    setState(() => polylines[id] = polyline);
  }
}
