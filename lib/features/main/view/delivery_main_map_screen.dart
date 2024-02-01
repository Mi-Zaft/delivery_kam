import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class DeliveryMainMapScreen extends StatefulWidget {
  final VoidCallback openDrawer;
  const DeliveryMainMapScreen({
    required this.openDrawer,
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
    return Stack(
      children: [
        FlutterMap(
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
            PolylineLayer(
              polylines: [
                Polyline(
                    points: polylineCoordinates,
                    color: Colors.red,
                    strokeWidth: 5)
              ],
            )
          ],
        ),
        Column(children: [
          const Padding(padding: EdgeInsets.only(bottom: 33)),
          Row(
            children: [
              const Padding(padding: EdgeInsets.only(left: 16)),
              InkWell(
                onTap: () {
                  widget.openDrawer();
                },
                child: Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white, // Цвет круга
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.menu,
                      color: Color.fromRGBO(16, 124, 135, 1),
                    ),
                  ),
                ),
              )
            ],
          )
        ])
      ],
    );
  }
}
