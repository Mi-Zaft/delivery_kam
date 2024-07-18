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
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(color: Colors.white),
        child: BlocBuilder<OrderHistoryBloc, OrderHistoryState>(
          bloc: _orderHistoryBloc,
          builder: (context, state) {
            if (state is OrderHistoryListLoadSuccess) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 10.0),
                      child: ListView.builder(
                        padding: const EdgeInsets.only(bottom: 25),
                        itemCount: state.orders.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext listContext, int index) {
                          return OrderItem(
                            id: state.orders[index].id,
                            date: state.orders[index].formattedDate,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
