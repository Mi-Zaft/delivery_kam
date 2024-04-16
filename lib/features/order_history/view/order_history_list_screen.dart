import 'package:delivery_kam/features/order_history/bloc/order_history_bloc.dart';
import 'package:delivery_kam/features/order_history/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderHistoryListScreen extends StatefulWidget {
  const OrderHistoryListScreen({super.key});

  @override
  State<OrderHistoryListScreen> createState() => _OrderHistoryListScreenState();
}

class _OrderHistoryListScreenState extends State<OrderHistoryListScreen> {
  final OrderHistoryBloc _orderHistoryBloc = OrderHistoryBloc();
  @override
  void initState() {
    super.initState();
    _orderHistoryBloc.add(OrderHistoryLoad());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('История заказов'),
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: BlocBuilder<OrderHistoryBloc, OrderHistoryState>(
          bloc: _orderHistoryBloc,
          builder: (context, state) {
            if (state is OrderHistoryListLoadSuccess) {
              return Column(
                children: [
                  ListView.builder(
                    padding: const EdgeInsets.only(
                        top: 10, left: 24, right: 24, bottom: 25),
                    itemCount: state.orders.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext listContext, int index) {
                      return OrderItem(
                          id: state.orders[index].id,
                          date: state.orders[index].formattedDate);
                    },
                  ),
                  const Spacer()
                ],
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
