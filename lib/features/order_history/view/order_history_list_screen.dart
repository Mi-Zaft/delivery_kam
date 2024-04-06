import 'package:delivery_kam/features/order_history/bloc/order_history_bloc.dart';
import 'package:delivery_kam/features/order_history/widgets/order_item.dart';
import 'package:flutter/material.dart';

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
        child: ListView(
          padding:
              const EdgeInsets.only(top: 10, left: 24, right: 24, bottom: 25),
          children: const [
            OrderItem(id: 'qwe', date: '28 января 2024г. 11:56'),
            OrderItem(id: 'qwe', date: '27 января 2024г. 12:32'),
            OrderItem(id: 'qwe', date: '26 января 2024г. 13:12'),
            OrderItem(id: 'qwe', date: '25 января 2024г. 03:51'),
            OrderItem(id: 'qwe', date: '24 января 2024г. 09:31'),
            OrderItem(id: 'qwe', date: '23 января 2024г. 11:24'),
            OrderItem(id: 'qwe', date: '22 января 2024г. 10:29'),
            OrderItem(id: 'qwe', date: '21 января 2024г. 12:13'),
            OrderItem(id: 'qwe', date: '20 января 2024г. 15:02'),
            OrderItem(id: 'qwe', date: '19 января 2024г. 17:09'),
            OrderItem(id: 'qwe', date: '18 января 2024г. 14:17'),
            OrderItem(id: 'qwe', date: '18 января 2024г. 13:01'),
            OrderItem(id: 'qwe', date: '17 января 2024г. 16:57'),
            OrderItem(id: 'qwe', date: '16 января 2024г. 19:43'),
            OrderItem(id: 'qwe', date: '15 января 2024г. 21:19'),
            OrderItem(id: 'qwe', date: '14 января 2024г. 08:48'),
          ],
        ),
      ),
    );
  }
}
