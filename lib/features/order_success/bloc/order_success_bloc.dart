import 'package:delivery_kam/models/order.dart';
import 'package:delivery_kam/services/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'order_success_event.dart';
part 'order_success_state.dart';

class OrderSuccessBloc extends Bloc<OrderSuccessEvent, OrderSuccessState> {
  OrderSuccessBloc() : super(OrderSuccessInitial()) {
    on<OrderSuccessEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<OrderLoadById>((event, emit) async {
      Response response = await ApiService().fetchData('/api/v1/order/${event.orderId}');
      if (response.statusCode == 200) {
        Order order = Order.fromJson(response.data);
        emit(OrderSuccessLoaded(order: order));
      }
    });
  }
}