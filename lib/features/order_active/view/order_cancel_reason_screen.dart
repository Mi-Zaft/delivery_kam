import 'package:delivery_kam/features/order_active/bloc/order_active_bloc.dart';
import 'package:delivery_kam/features/order_active/widgets/order_cancel_reason_item.dart';
import 'package:delivery_kam/models/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderCancelReasonScreen extends StatefulWidget {
  const OrderCancelReasonScreen({super.key});

  @override
  State<OrderCancelReasonScreen> createState() =>
      _OrderCancelReasonScreenState();
}

class _OrderCancelReasonScreenState extends State<OrderCancelReasonScreen> {
  OrderCancelReason? _reason;
  final FocusNode _focusNode = FocusNode();
  final _orderActiveBloc = OrderActiveBloc();
  final TextEditingController _commentTextEditingController =
      TextEditingController();

  void updateSelectedTile(OrderCancelReason newReason) {
    setState(() {
      _reason = newReason;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40).copyWith(top: 20),
              height: 230,
              width: double.infinity,
              child: Column(
                children: [
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Ваш заказ отменен',
                          style: TextStyle(fontSize: 24),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Image.asset('assets/images/order/iconOkey.png')
                      ],
                    ),
                  )
                ],
              ),
            );
          });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _commentTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String orderId = args['orderId'];

    return Scaffold(
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24).copyWith(bottom: 25),
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
        child: BlocListener<OrderActiveBloc, OrderActiveState>(
          bloc: _orderActiveBloc,
          listener: (context, state) {
            if (state is OrderCancelReasonSuccess) {
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            }
          },
          child: ElevatedButton(
              onPressed: () {
                if (_reason != null) {
                  _orderActiveBloc.add(
                    OrderCancelResonLoad(
                      orderId: orderId,
                      reason: _reason!.value,
                      comment: _commentTextEditingController.text
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.transparent,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: const Text(
                'Отправить',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
              )),
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            OrderCancelReasonItem(
              title: 'Слишком долго ждать',
              leadingImage: Image.asset('assets/images/order/deliveryTime.png'),
              onTap: () => {updateSelectedTile(OrderCancelReason.deliveryTime)},
              active: _reason == OrderCancelReason.deliveryTime,
            ),
            OrderCancelReasonItem(
              title: 'Изменились планы',
              leadingImage: Image.asset('assets/images/order/changePlans.png'),
              onTap: () => {updateSelectedTile(OrderCancelReason.changePlans)},
              active: _reason == OrderCancelReason.changePlans,
            ),
            OrderCancelReasonItem(
              title: 'Курьер попросил отменить',
              leadingImage: Image.asset('assets/images/order/byCourier.png'),
              onTap: () => {updateSelectedTile(OrderCancelReason.byCourier)},
              active: _reason == OrderCancelReason.byCourier,
            ),
            OrderCancelReasonItem(
              title: 'Не устроила цена доставки',
              leadingImage: Image.asset('assets/images/order/expensive.png'),
              onTap: () => {updateSelectedTile(OrderCancelReason.expensive)},
              active: _reason == OrderCancelReason.expensive,
            ),
            GestureDetector(
              onTap: () => {_focusNode.requestFocus()},
              child: Container(
                padding: const EdgeInsets.all(14),
                margin: const EdgeInsets.all(24),
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Spacer(),
                        Image.asset('assets/images/order/comment.png'),
                        const SizedBox(
                          width: 16,
                        ),
                        const Text(
                          'Комментарий',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(80, 80, 80, 1),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                    TextField(
                      focusNode: _focusNode,
                      controller: _commentTextEditingController,
                      style: const TextStyle(fontSize: 20),
                      cursorColor: Colors.black,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text(
          'Почему решили отменить заказ?',
          maxLines: 3,
          style: TextStyle(
            fontSize: 24,
            color: Color.fromRGBO(80, 80, 80, 1),
          ),
        ),
      ),
    );
  }
}
