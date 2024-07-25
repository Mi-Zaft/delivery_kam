part of 'order_success_bloc.dart';

class OrderSuccessEvent {}

class OrderLoadById extends OrderSuccessEvent {
  String orderId;
  OrderLoadById({required this.orderId});
}
