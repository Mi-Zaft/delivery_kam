part of 'order_active_bloc.dart';

class OrderActiveEvent {}

class OrderActiveLoad extends OrderActiveEvent {}

class OrderActiveCancel extends OrderActiveEvent {
  final String orderId;

  OrderActiveCancel({required this.orderId});
}
