import 'package:delivery_kam/features/main/bloc/delivery_main_bloc.dart';
import 'package:delivery_kam/models/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeliveryMainBottomNavbar extends StatefulWidget {
  final DeliveryMainBloc deliveryMainBloc;
  final Function() makeOrder;
  final Order? order;
  const DeliveryMainBottomNavbar(
      {super.key,
      required this.deliveryMainBloc,
      required this.makeOrder,
      required this.order});
  @override
  State<DeliveryMainBottomNavbar> createState() =>
      _DeliveryMainBottomNavbarState();
}

class _DeliveryMainBottomNavbarState extends State<DeliveryMainBottomNavbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding:
          const EdgeInsets.only(bottom: 25.0, top: 10, left: 16, right: 16),
      child: SizedBox(
        width: double.infinity,
        child: BlocBuilder<DeliveryMainBloc, DeliveryMainState>(
            bloc: widget.deliveryMainBloc,
            builder: (context, state) {
              if (state is DeliveryMainLoading) {
                return ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: const Color.fromRGBO(195, 195, 195, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: const SizedBox(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color.fromRGBO(32, 191, 208, 1),
                      ),
                    ),
                  ),
                );
              } else if (state is DeliveryMainOrderPriceSuccess) {
                return Container(
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
                      widget.makeOrder();
                      if (widget.order != null) {
                        widget.deliveryMainBloc
                            .add(OrderCreateLoading(widget.order!));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors
                          .transparent, // Чтобы фон ElevatedButton был прозрачным
                      elevation: 0, // Отключаем подъем тени кнопки
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Text(
                      'Заказать за ${state.orderPrice.price}₽',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                );
              } else {
                return ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: const Color.fromRGBO(195, 195, 195, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: const Text(
                    "Укажите адрес",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                );
              }
            }),
      ),
    );
  }
}
