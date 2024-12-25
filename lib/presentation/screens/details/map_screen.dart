import 'package:flutter/material.dart';
import 'package:food_app/domain/models/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final Location location;

  const MapScreen({
    super.key,
    required this.location,
  });

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  late LatLng _initialPosition;

  @override
  void initState() {
    super.initState();
    _initialPosition = LatLng(widget.location.latitude, widget.location.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _initialPosition,
          zoom: 15,
        ),
        markers: {
          Marker(
            markerId: const MarkerId('pin'),
            position: _initialPosition,
            infoWindow: const InfoWindow(
              title: 'Restaurant Location',
            ),
          ),
        },
        onMapCreated: (controller) {
        },
      ),
    );
  }
}