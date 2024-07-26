part of 'order_success_bloc.dart';

class OrderSuccessState {}

class OrderSuccessInitial extends OrderSuccessState {}

class OrderSuccessLoaded extends OrderSuccessState {
  Order order;
  OrderSuccessLoaded({required this.order});
}

class OrderSuccessCommentLoad extends OrderSuccessState {}

class OrderSuccessCommentSuccess extends OrderSuccessState {
  String comment;
  OrderSuccessCommentSuccess({required this.comment});
}
