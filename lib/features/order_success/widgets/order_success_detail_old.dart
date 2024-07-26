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

class _OrderSuccessDetailState extends State<OrderSuccessDetail> {
  final String orderId = "33d555aa-fb85-4a78-801a-d1f36ed18ee2";
  List<Widget> addressList = [];
  Order? order;
  String? date;
  final orderSuccessBloc = OrderSuccessBloc();

  @override
  void initState() {
    super.initState();
    orderSuccessBloc.add(OrderLoadById(orderId: orderId));
  }

  String formatDate(int timestamp) {
    initializeDateFormatting('ru', null);
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    DateFormat dateFormat = DateFormat('d MMMM y \'г.\' HH:mm', 'ru_RU');
    return dateFormat.format(date);
  }

  @override
  Widget build(BuildContext context) {
    final FocusNode textFieldFocus = FocusNode();
    final TextEditingController commentTextFieldController =
        TextEditingController();

    return BlocListener<OrderSuccessBloc, OrderSuccessState>(
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
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24)
            .copyWith(top: 20)
            .copyWith(bottom: 20),
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
        child: Column(children: [
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
          if (order?.courier?.type != 'walk')
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
              Text(
                'цена: ${order?.price}₽',
                style: const TextStyle(fontSize: 16),
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
                  label: 'Александра',
                  isEnable: true),
              const Spacer(),
              OrderSuccessInfoCard(
                  imagePath: 'assets/images/main/iconcourier.png',
                  label: 'Пеший курьер',
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
                const Text(
                  'Заказ выполнен',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  width: 10,
                ),
                Image.asset('assets/images/order/iconOkey.png')
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(color: Colors.white),
            child: GestureDetector(
              onTap: () {
                textFieldFocus.requestFocus();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10)
                    .copyWith(top: 15)
                    .copyWith(bottom: 15),
                margin: const EdgeInsets.symmetric(horizontal: 25)
                    .copyWith(top: 30)
                    .copyWith(bottom: 15),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
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
                      Image.asset('assets/images/order/comment.png'),
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
                        onEditingComplete: () => {textFieldFocus.unfocus()},
                        focusNode: textFieldFocus,
                        controller: commentTextFieldController,
                        maxLines: null,
                        style: const TextStyle(
                            fontSize: 16,
                            color: Color.fromRGBO(80, 80, 80, 100)),
                        cursorColor: const Color.fromRGBO(80, 80, 80, 100),
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ),
          GradientButton(
              onPressed: () {
                print('Comment send');
              },
              label: 'Отправить')
        ]),
      ),
    );
  }
}
