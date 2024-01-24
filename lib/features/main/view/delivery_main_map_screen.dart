import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class DeliveryMainMapScreen extends StatefulWidget {
  const DeliveryMainMapScreen({
    super.key,
  });

  @override
  State<DeliveryMainMapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<DeliveryMainMapScreen> {
  late final MapController _mapController;
  late List<LatLng> polylineCoordinates;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    polylineCoordinates = [];
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: _mapController,
      options: const MapOptions(
        initialCenter: LatLng(45.041646, 38.973280),
        initialZoom: 15,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.flutter_map_example',
        ),
        PolylineLayer(polylines: [
          Polyline(
              points: polylineCoordinates, color: Colors.red, strokeWidth: 5)
        ])
      ],
    );
  }
}
