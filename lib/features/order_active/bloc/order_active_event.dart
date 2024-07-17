part of 'order_active_bloc.dart';

class OrderActiveEvent {}

class OrderActiveLoad extends OrderActiveEvent {
  final String orderId;

  OrderActiveLoad({required this.orderId});
}

class OrderActiveCancel extends OrderActiveEvent {
  final String orderId;

  OrderActiveCancel({required this.orderId});
}

class OrderCancelResonLoad extends OrderActiveEvent {
  final String orderId;
  final String reason;
  final String? comment;

  OrderCancelResonLoad({
    required this.orderId,
    required this.reason,
    this.comment,
  });
}
