import 'package:delivery_kam/models/order.dart';
import 'package:delivery_kam/services/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'order_history_event.dart';
part 'order_history_state.dart';

class OrderHistoryBloc extends Bloc<OrderHistoryEvent, OrderHistoryState> {
  OrderHistoryBloc() : super(OrderHistoryInitial()) {
    on<OrderHistoryLoad>((event, emit) async {
      Response response = await ApiService().fetchData('/api/v1/order');
      List<OrderHistoryItem> orders = [];
        List responseData;
        if (response.data is List) {
          responseData = response.data;
          for (var i = 0; i < responseData.length; i++) {
            orders.add(OrderHistoryItem.fromJson(responseData[i]));
          }
          emit(
            OrderHistoryListLoadSuccess(orders: orders),
          );
        }
    });
  }
}