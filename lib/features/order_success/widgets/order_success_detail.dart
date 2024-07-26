import 'package:delivery_kam/features/main/widgets/gradient_button.dart';
import 'package:delivery_kam/features/order_success/bloc/order_success_bloc.dart';
import 'package:delivery_kam/features/order_success/widgets/order_success_info_card.dart';
import 'package:delivery_kam/models/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OrderSuccessDetail extends StatefulWidget {
  const OrderSuccessDetail({super.key});

  @override
  State<OrderSuccessDetail> createState() => _OrderSuccessDetailState();
}

String formatDate(int timestamp) {
  initializeDateFormatting('ru', null);
  DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  DateFormat dateFormat = DateFormat('d MMMM y \'г.\' HH:mm', 'ru_RU');
  return dateFormat.format(date);
}

String courierName(Order? order) {
  if (order?.courier != null) {
    return order!.courier!.name;
  } else {
    return 'Отсутствует';
  }
}

class _OrderSuccessDetailState extends State<OrderSuccessDetail> {
  final DraggableScrollableController _orderSuccessDraggableSheetController =
      DraggableScrollableController();
  List<Widget> addressList = [];
  Order? order;
  String? date;
  final orderSuccessBloc = OrderSuccessBloc();
  final double maxChildSize = .9;
  final double minChildSize = .2;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final FocusNode textFieldFocus = FocusNode();
    final TextEditingController commentTextFieldController =
        TextEditingController();
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String orderId = args['orderId'];
    if (orderSuccessBloc.state is OrderSuccessInitial) {
      orderSuccessBloc.add(OrderLoadById(orderId: orderId));
    }

    return SizedBox.expand(
      child: DraggableScrollableSheet(
          minChildSize: minChildSize,
          maxChildSize: maxChildSize,
          initialChildSize: 0.5,
          snap: false,
          snapSizes: [
            minChildSize,
            maxChildSize,
          ],
          controller: _orderSuccessDraggableSheetController,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.25),
                      spreadRadius: 5,
                      blurRadius: 5,
                    )
                  ]),
              child: ListView(controller: scrollController, children: [
                BlocListener<OrderSuccessBloc, OrderSuccessState>(
                  bloc: orderSuccessBloc,
                  listener: (context, state) {
                    if (state is OrderSuccessLoaded) {
                      order = state.order;
                      if (order != null) {
                        setState(() {
                          for (int i = 0; i < order!.address.length; i++) {
                            addressList.add(
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        order!.address[i].addressRow,
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                      const Spacer()
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            );
                          }
                          date = formatDate(order!.createdAt!);
                        });
                      }
                    } else if (state is OrderSuccessCommentSuccess) {
                      setState(() {
                        order?.comment = 'text';
                      });
                      showModalBottomSheet(
                          context: context,
                          elevation: 0,
                          builder: (BuildContext context) {
                            return Wrap(children: [
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 24)
                                        .copyWith(top: 40)
                                        .copyWith(bottom: 60),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(204, 230, 237, 1),
                                  borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(30))
                                      .copyWith(
                                    topRight: const Radius.circular(30),
                                  ),
                                ),
                                child: const Column(
                                  children: [
                                    Text(
                                      'Спасибо за отзыв',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(bottom: 20)),
                                    Text(
                                      'Мы всегда рады получить отзыв о нашей работе',
                                      style: TextStyle(fontSize: 16),
                                    )
                                  ],
                                ),
                              ),
                            ]);
                          });
                    } else if (state is OrderSuccessCommentLoad) {
                      setState(() {});
                    }
                  },
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Skeletonizer(
                            enabled: order == null,
                            child: Text(
                              date ?? '23 июля 2024г. 16:44',
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                          const Spacer()
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      if (order?.courier != null &&
                          order?.courier?.type != 'walk')
                        Row(
                          children: [
                            Skeletonizer(
                              enabled: order == null,
                              child: Text(
                                "${order?.courier?.carColor} ${order?.courier?.carModel}",
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                            const Spacer()
                          ],
                        ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          const Text(
                            'цена: ',
                            style: const TextStyle(fontSize: 16),
                          ),
                          Skeletonizer(
                            enabled: order?.price == null,
                            child: Text(
                              "${order?.price}₽",
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          const Spacer()
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        thickness: 1.5,
                        color: Color.fromRGBO(80, 80, 80, 1),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: addressList,
                      ),
                      const Divider(
                        thickness: 1.5,
                        color: Color.fromRGBO(80, 80, 80, 1),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(),
                          OrderSuccessInfoCard(
                              imagePath: 'assets/images/main/iconavatar.png',
                              label: courierName(order),
                              isEnable: true),
                          const Spacer(),
                          if (order?.byCar == false)
                            OrderSuccessInfoCard(
                                imagePath: 'assets/images/main/iconcourier.png',
                                label: 'Пеший курьер',
                                isEnable: true),
                          if (order?.byCar == true)
                            OrderSuccessInfoCard(
                                imagePath: 'assets/images/main/iconCar.png',
                                label: 'Авто курьер',
                                isEnable: true),
                          const Spacer(),
                        ],
                      ),
                      const Divider(
                        thickness: 1.5,
                        color: Color.fromRGBO(80, 80, 80, 1),
                      ),
                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (order?.status == 'cancelled')
                              const Text(
                                'Заказ отменен',
                                style: TextStyle(fontSize: 20),
                              ),
                            if (order?.status == 'created')
                              const Text(
                                'Заказ создан',
                                style: TextStyle(fontSize: 20),
                              ),
                            if (order?.status == 'processing')
                              const Text(
                                'Заказ выполняется',
                                style: TextStyle(fontSize: 20),
                              ),
                            if (order?.status == 'completed')
                              const Text(
                                'Заказ выполнен',
                                style: TextStyle(fontSize: 20),
                              ),
                            const SizedBox(
                              width: 10,
                            ),
                            if (order?.status == 'completed')
                              Image.asset('assets/images/order/iconOkey.png')
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // Добавление комментария
                      if (order != null &&
                          order?.comment != null &&
                          order!.comment.isEmpty)
                        Column(
                          children: [
                            Container(
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              child: GestureDetector(
                                onTap: () {
                                  textFieldFocus.requestFocus();
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 10)
                                          .copyWith(top: 15)
                                          .copyWith(bottom: 15),
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 25)
                                          .copyWith(top: 30)
                                          .copyWith(bottom: 15),
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color.fromRGBO(0, 0, 0, 0.25),
                                          spreadRadius: 5,
                                          blurRadius: 5,
                                        )
                                      ]),
                                  child: Column(children: [
                                    Row(
                                      children: [
                                        const Spacer(),
                                        Image.asset(
                                            'assets/images/order/comment.png'),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        const Text(
                                          'Обращение',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        const Spacer()
                                      ],
                                    ),
                                    SizedBox(
                                      height: 40,
                                      width: double.infinity,
                                      child: SingleChildScrollView(
                                        child: TextField(
                                          textInputAction: TextInputAction.done,
                                          onEditingComplete: () =>
                                              {textFieldFocus.unfocus()},
                                          focusNode: textFieldFocus,
                                          controller:
                                              commentTextFieldController,
                                          maxLines: null,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Color.fromRGBO(
                                                  80, 80, 80, 100)),
                                          cursorColor: const Color.fromRGBO(
                                              80, 80, 80, 100),
                                          decoration: const InputDecoration(
                                              border: InputBorder.none),
                                        ),
                                      ),
                                    ),
                                  ]),
                                ),
                              ),
                            ),
                            GradientButton(
                                disabled: orderSuccessBloc.state
                                    is OrderSuccessCommentLoad,
                                onPressed: () {
                                  if (commentTextFieldController
                                      .text.isNotEmpty) {
                                    orderSuccessBloc.add(
                                      OrderSuccessCommentSend(
                                        orderId: orderId,
                                        comment:
                                            commentTextFieldController.text,
                                      ),
                                    );
                                  }
                                },
                                label: 'Отправить'),
                          ],
                        ),
                      // Если комментарий уже есть
                      if (order != null &&
                          order?.comment != null &&
                          order!.comment.isNotEmpty)
                        const Text(
                          'Комментарий по данному заказу был отправлен ранее',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ]),
            );
          }),
    );
  }
}
