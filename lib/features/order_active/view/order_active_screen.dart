import 'package:delivery_kam/features/main/view/delivery_main_map_screen.dart';
import 'package:delivery_kam/features/main/widgets/delivery_main_drawer.dart';
import 'package:delivery_kam/features/order_active/bloc/order_active_bloc.dart';
import 'package:delivery_kam/features/order_active/widgets/order_active_action_button.dart';
import 'package:delivery_kam/features/order_active/widgets/order_active_modal_cancel.dart';
import 'package:delivery_kam/models/order.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderActiveScreen extends StatefulWidget {
  final Order? order;
  const OrderActiveScreen({super.key, this.order});

  @override
  State<OrderActiveScreen> createState() => _OrderActiveScreenState();
}

class _OrderActiveScreenState extends State<OrderActiveScreen> {
  final orderActiveBloc = OrderActiveBloc();
  final double minChildSize = .55;
  final double maxChildSize = .80;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Size? _size;

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
        print('Message is: ${message.data}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    late Order order;
    if (widget.order == null) {
      final Map<String, dynamic> args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      order = args['order'];
    } else if (widget.order != null) {
      order = widget.order!;
    }

    // final height = MediaQuery.of(context).size.height;
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
        SizedBox.expand(
          child: NotificationListener<DraggableScrollableNotification>(
            onNotification: (notification) {
              return true;
            },
            child: DraggableScrollableSheet(
              // initialChildSize: getTheRightSize(height),
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
                                Skeletonizer(
                                  enabled: order.courier?.name == null,
                                  child: Text(
                                    order.courier?.name ?? '',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                )
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 15),
                            ),
                            if (order.courier?.carModel != null)
                              Row(
                                children: [
                                  Skeletonizer(
                                    enabled: order.courier?.carModel == null,
                                    child: Text(
                                      order.courier?.carModel ?? '',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            const Padding(
                              padding: EdgeInsets.only(top: 15),
                            ),
                            Row(
                              children: [
                                Text(
                                  'цена: ${order.price ?? '?'}₽',
                                  style: const TextStyle(fontSize: 16),
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
                                  onTap: () =>
                                      _launchCaller(order.courier?.phone),
                                  imagePath: 'assets/images/main/iconPhone.png',
                                  label: 'Позвонить',
                                  isEnable: order.courier?.phone != null,
                                ),
                                if (order.courier?.carModel != null)
                                  OrderActiveActionButton(
                                    imagePath: 'assets/images/main/iconCar.png',
                                    label:
                                        order.courier?.carLicensePlate ?? ' ',
                                    isEnable: true,
                                    isSkeletonizer:
                                        order.courier?.carLicensePlate == null,
                                  ),
                                if (order.courier?.carColor == null)
                                  OrderActiveActionButton(
                                      imagePath:
                                          'assets/images/main/iconcourier.png',
                                      label: 'Пеший\nкурьер',
                                      isEnable: true),
                                OrderActiveActionButton(
                                  imagePath:
                                      'assets/images/main/iconMessage.png',
                                  label: 'Написать',
                                  isEnable: false,
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
                                  'Поиск курьера',
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
                                      onPressed: () {
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return OrderActiveModalCancel(
                                                bloc: orderActiveBloc,
                                                orderId: order.id,
                                              );
                                            });
                                      },
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
