import 'package:delivery_kam/features/main/view/delivery_main_map_screen.dart';
import 'package:delivery_kam/features/main/widgets/delivery_main_drawer.dart';
import 'package:delivery_kam/features/order_success/widgets/order_success_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class OrderSuccessScreen extends StatelessWidget {
  OrderSuccessScreen({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final MapController mapController = MapController();

  void openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const DeliveryMainDrawer(),
      body: Stack(children: [
        DeliveryMainMapScreen(
          openDrawer: openDrawer,
          markers: const [],
          mapController: mapController,
          polylineCoordinates: const [],
        ),
        const OrderSuccessDetail()
      ]),
    );
  }
}
