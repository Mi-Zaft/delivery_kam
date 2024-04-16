part of 'order_history_bloc.dart';

class OrderHistoryState {}

class OrderHistoryInitial extends OrderHistoryState {}

class OrderHistoryListLoadSuccess extends OrderHistoryState {
  OrderHistoryListLoadSuccess({required this.orders});
  final List<OrderHistoryItem> orders;
}
