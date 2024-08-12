import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class DeliveryMainMapScreen extends StatefulWidget {
  final VoidCallback openDrawer;
  final List<Marker> markers;
  final MapController mapController;
  final List<LatLng> polylineCoordinates;
  const DeliveryMainMapScreen({
    required this.openDrawer,
    super.key,
    required this.markers,
    required this.polylineCoordinates,
    required this.mapController,
  });

  @override
  State<DeliveryMainMapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<DeliveryMainMapScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          mapController: widget.mapController,
          options: const MapOptions(
            initialCenter: LatLng(53.0188434, 158.6486179),
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
                    points: widget.polylineCoordinates,
                    color: const Color.fromRGBO(32, 191, 208, 1),
                    strokeWidth: 7)
              ],
            ),
            MarkerLayer(
              markers: widget.markers,
            ),
          ],
        ),
        Column(children: [
          const Padding(padding: EdgeInsets.only(bottom: 40)),
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
