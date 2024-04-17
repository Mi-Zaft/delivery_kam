import 'package:delivery_kam/features/main/view/delivery_main_map_screen.dart';
import 'package:delivery_kam/features/main/widgets/delivery_main_drawer.dart';
import 'package:flutter/material.dart';

class OrderActiveScreen extends StatefulWidget {
  const OrderActiveScreen({super.key});

  @override
  State<OrderActiveScreen> createState() => _OrderActiveScreenState();
}

class _OrderActiveScreenState extends State<OrderActiveScreen> {
  final double minChildSize = .39;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const DeliveryMainDrawer(),
      body: Stack(children: [
        DeliveryMainMapScreen(openDrawer: openDrawer),
        SizedBox.expand(
          child: NotificationListener<DraggableScrollableNotification>(
            onNotification: (notification) {
              return true;
            },
            child: DraggableScrollableSheet(
              initialChildSize: minChildSize,
              minChildSize: minChildSize,
              maxChildSize: minChildSize,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                          spreadRadius: 5,
                          blurRadius: 5,
                        )
                      ]),
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    controller: scrollController,
                    child: GestureDetector(
                      onTap: () =>
                          {FocusScope.of(context).requestFocus(FocusNode())},
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                          ),
                          color: Colors.white,
                        ),
                        child: const Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ]),
    );
  }
}
