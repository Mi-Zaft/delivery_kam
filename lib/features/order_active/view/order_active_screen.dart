import 'package:delivery_kam/features/main/view/delivery_main_map_screen.dart';
import 'package:delivery_kam/features/main/widgets/delivery_main_drawer.dart';
import 'package:delivery_kam/features/order_active/widgets/order_active_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class OrderActiveScreen extends StatefulWidget {
  const OrderActiveScreen({super.key});

  @override
  State<OrderActiveScreen> createState() => _OrderActiveScreenState();
}

class _OrderActiveScreenState extends State<OrderActiveScreen> {
  final double minChildSize = .55;
  final double maxChildSize = .80;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    final MapController mapController = MapController();
    return Scaffold(
      key: _scaffoldKey,
      drawer: const DeliveryMainDrawer(),
      body: Stack(children: [
        DeliveryMainMapScreen(
          openDrawer: openDrawer,
          markers: const [],
          mapController: mapController,
        ),
        SizedBox.expand(
          child: NotificationListener<DraggableScrollableNotification>(
            onNotification: (notification) {
              return true;
            },
            child: DraggableScrollableSheet(
              initialChildSize: minChildSize,
              minChildSize: minChildSize,
              maxChildSize: maxChildSize,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
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
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 20),
                            ),
                            const Row(
                              children: [
                                Text(
                                  'Через ~10 минут прибудет',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 15),
                            ),
                            Row(
                              children: [
                                CircleAvatar(
                                  child: Image.asset(
                                    'assets/images/main/iconavatar.png',
                                    width: 60,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                ),
                                const Text(
                                  'Александра',
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 15),
                            ),
                            const Row(
                              children: [
                                Text(
                                  'белый Hyundai Solaris',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 15),
                            ),
                            const Row(
                              children: [
                                Text(
                                  'цена: 240₽',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            const Divider(
                              thickness: 1.5,
                              color: Color.fromRGBO(80, 80, 80, 1),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                OrderActiveActionButton(
                                  imagePath: 'assets/images/main/iconPhone.png',
                                  label: 'Позвонить',
                                ),
                                OrderActiveActionButton(
                                  imagePath:
                                      'assets/images/main/iconMessage.png',
                                  label: 'о172рв 123',
                                ),
                                OrderActiveActionButton(
                                  imagePath:
                                      'assets/images/main/iconMessage.png',
                                  label: 'Написать',
                                ),
                              ],
                            ),
                            const Divider(
                              thickness: 1.5,
                              color: Color.fromRGBO(80, 80, 80, 1),
                            ),
                            const Row(
                              children: [
                                Spacer(),
                                Text(
                                  'Заказ выполняется',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromRGBO(80, 80, 80, 1),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                ),
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                    color: Color.fromRGBO(80, 80, 80, 1),
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 15),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color.fromRGBO(175, 223, 234, 1),
                                          Color.fromRGBO(33, 190, 210, 1)
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15),
                                        backgroundColor: Colors
                                            .transparent, // Чтобы фон ElevatedButton был прозрачным
                                        elevation:
                                            0, // Отключаем подъем тени кнопки
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                      ),
                                      child: const Text(
                                        'Отменить заказ',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 15),
                            )
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
