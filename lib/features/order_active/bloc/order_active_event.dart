part of 'order_active_bloc.dart';

class OrderActiveEvent {}

class OrderActiveLoad extends OrderActiveEvent {
  final String orderId;

  OrderActiveLoad({required this.orderId});
}

class OrderActiveCancel extends OrderActiveEvent {
  final String orderId;
  final String reason;

  OrderActiveCancel({required this.reason, required this.orderId});
}
