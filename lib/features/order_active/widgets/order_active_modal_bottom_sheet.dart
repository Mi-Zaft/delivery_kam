import 'package:delivery_kam/features/order_active/bloc/order_active_bloc.dart';
import 'package:delivery_kam/features/order_active/widgets/order_active_action_button.dart';
import 'package:delivery_kam/features/order_active/widgets/order_active_modal_cancel.dart';
import 'package:delivery_kam/models/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

// ignore: must_be_immutable
class OrderActiveModalBottomSheet extends StatefulWidget {
  Order? order;
  Function onCall;
  OrderActiveBloc bloc;
  OrderActiveModalBottomSheet({super.key, this.order, required this.onCall, required this.bloc});

  @override
  State<OrderActiveModalBottomSheet> createState() => _OrderActiveModalBottomSheetState();
}

class _OrderActiveModalBottomSheetState extends State<OrderActiveModalBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderActiveBloc, OrderActiveState>(
      bloc: widget.bloc,
      listener: (context, state) {
        if (state is OrderAcitveLoadSuccess) {
          setState(() {
            widget.order = state.order;
          });
        }
      },
      child: PopScope(
        child: Container(
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
            child: GestureDetector(
              onTap: () => {FocusScope.of(context).requestFocus(FocusNode())},
              child: Container(
                padding: const EdgeInsets.only(bottom: 20),
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
                          enabled: widget.order?.courier?.name == null,
                          child: Text(
                            widget.order?.courier?.name ?? '',
                            style: const TextStyle(fontSize: 16),
                          ),
                        )
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 15),
                    ),
                    if (widget.order?.courier?.carModel != null)
                      Row(
                        children: [
                          Skeletonizer(
                            enabled: widget.order?.courier?.carModel == null,
                            child: Text(
                              widget.order?.courier?.carModel ?? '',
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
                          'цена: ${widget.order?.price ?? '?'}₽',
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
                          onTap: () => widget.onCall(widget.order?.courier?.phone),
                          imagePath: 'assets/images/main/iconPhone.png',
                          label: 'Позвонить',
                          isEnable: widget.order?.courier?.phone != null,
                        ),
                        if (widget.order?.byCar == true)
                          OrderActiveActionButton(
                            imagePath: 'assets/images/main/iconCar.png',
                            label: widget.order?.courier?.carLicensePlate ?? 'Номер',
                            isEnable: true,
                            isSkeletonizer:
                                widget.order?.courier?.carLicensePlate == null,
                          ),
                        if (widget.order?.byCar == false)
                          OrderActiveActionButton(
                              imagePath: 'assets/images/main/iconcourier.png',
                              label: 'Пеший\nкурьер',
                              isEnable: true),
                        OrderActiveActionButton(
                          imagePath: 'assets/images/main/iconMessage.png',
                          label: 'Написать',
                          isEnable: false,
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 1.5,
                      color: Color.fromRGBO(80, 80, 80, 1),
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        Text(
                          widget.order?.courier == null
                              ? 'Поиск курьера'
                              : 'Курьер выполняет заказ',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(80, 80, 80, 1),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 10),
                        ),
                        const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            color: Color.fromRGBO(80, 80, 80, 1),
                          ),
                        ),
                        const Spacer(),
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
                                if (widget.order != null) {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return OrderActiveModalCancel(
                                          bloc: widget.bloc,
                                          orderId: widget.order!.id,
                                        );
                                      });
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                backgroundColor: Colors
                                    .transparent, // Чтобы фон ElevatedButton был прозрачным
                                elevation: 0, // Отключаем подъем тени кнопки
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
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
        ),
      ),
    );
  }
}
