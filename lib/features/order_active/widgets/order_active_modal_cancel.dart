import 'package:delivery_kam/features/order_active/bloc/order_active_bloc.dart';
import 'package:flutter/material.dart';

class OrderActiveModalCancel extends StatelessWidget {
  final OrderActiveBloc bloc;
  final String orderId;
  const OrderActiveModalCancel({
    super.key,
    required this.bloc,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40).copyWith(top: 20),
      height: 230,
      width: double.infinity,
      child: Column(
        children: [
          const Text(
            'Вы уверены, что хотите отменить заказ?',
            style:
                TextStyle(fontSize: 20, color: Color.fromRGBO(80, 80, 80, 1)),
            maxLines: 3,
          ),
          const Padding(padding: EdgeInsets.only(top: 15)),
          Container(
            width: double.infinity,
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
                bloc.add(OrderActiveCancel(orderId: orderId));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors
                    .transparent, // Чтобы фон ElevatedButton был прозрачным
                elevation: 0, // Отключаем подъем тени кнопки
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: const Text(
                'Да, отменить',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 15)),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: const BorderSide(
                        color: Color.fromRGBO(112, 112, 112, 1))),
              ),
              child: const Text('Нет, дождаться',
                  style: TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(112, 112, 112, 1),
                      fontWeight: FontWeight.w400)),
            ),
          ),
        ],
      ),
    );
  }
}
