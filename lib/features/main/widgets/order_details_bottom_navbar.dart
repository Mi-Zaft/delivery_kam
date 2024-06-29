import 'package:delivery_kam/features/main/bloc/delivery_main_bloc.dart';
import 'package:delivery_kam/models/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDetailsBottomNavbar extends StatefulWidget {
  final int price;
  final Order order;
  const OrderDetailsBottomNavbar({
    super.key,
    required this.price,
    required this.order,
  });
  @override
  State<OrderDetailsBottomNavbar> createState() =>
      _OrderDetailsBottomNavbarState();
}

class _OrderDetailsBottomNavbarState extends State<OrderDetailsBottomNavbar> {
  final deliveryMainBloc = DeliveryMainBloc();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding:
          const EdgeInsets.only(bottom: 25.0, top: 10, left: 16, right: 16),
      child: SizedBox(
        width: double.infinity,
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
          child: BlocListener<DeliveryMainBloc, DeliveryMainState>(
            bloc: deliveryMainBloc,
            listener: (context, state) {
              if (state is DeliveryMainOrderCreateSuccess) {
                Navigator.pushNamed(context, '/order-active',
                    arguments: {'orderId': state.order.id});
              }
            },
            child: BlocBuilder<DeliveryMainBloc, DeliveryMainState>(
              bloc: deliveryMainBloc,
              builder: (context, state) {
                if (state is DeliveryMainLoading) {
                  return ElevatedButton(
                    onPressed: () {
                      deliveryMainBloc.add(OrderCreateLoading(widget.order));
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        color: Colors.white,
                      ),
                    ),
                  );
                } else {
                  return ElevatedButton(
                    onPressed: () {
                      deliveryMainBloc.add(OrderCreateLoading(widget.order));
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Text(
                      'Заказать за ${widget.price}р',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
