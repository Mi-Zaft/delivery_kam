import 'package:delivery_kam/features/main/view/delivery_main_map_screen.dart';
import 'package:delivery_kam/features/main/widgets/delivery_main_drawer.dart';
import 'package:delivery_kam/features/order_active/bloc/order_active_bloc.dart';
import 'package:delivery_kam/features/order_active/widgets/order_active_modal_bottom_sheet.dart';
import 'package:delivery_kam/models/order.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class OrderActiveScreen extends StatefulWidget {
  Order? order;
  OrderActiveScreen({super.key, this.order});

  @override
  State<OrderActiveScreen> createState() => _OrderActiveScreenState();
}

class _OrderActiveScreenState extends State<OrderActiveScreen> {
  final orderActiveBloc = OrderActiveBloc();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Size? _size;
  final double minChildSize = .55;
  final double maxChildSize = .80;
  bool modalIsOpen = false;

  void openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  void _launchCaller(String? number) async {
    if (number != null) {
      final Uri url = Uri(scheme: 'tel', path: number);
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      }
    }
  }

  double getTheRightSize(double screenHeight) {
    final maxHeight = 0.73 * screenHeight;
    final calculatedHeight = _size?.height ?? maxHeight;
    return calculatedHeight > maxHeight
        ? maxHeight / screenHeight
        : calculatedHeight / screenHeight;
  }

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.data['type'] == 'courier_assigned') {
        if (widget.order != null) {
          orderActiveBloc.add(OrderActiveLoad(orderId: widget.order!.id));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.order == null) {
      final Map<String, dynamic> args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      widget.order = args['order'];
    } else if (widget.order != null) {
      widget.order = widget.order!;
    }

    final MapController mapController = MapController();
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
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            color: Colors.transparent,
            child: OrderActiveModalBottomSheet(
              order: widget.order,
              bloc: orderActiveBloc,
              onCall: _launchCaller,
            ),
          ),
        )
      ]),
    );
  }
}
