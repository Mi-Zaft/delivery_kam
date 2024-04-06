import 'package:delivery_kam/services/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'order_history_event.dart';
part 'order_history_state.dart';

class OrderHistoryBloc extends Bloc<OrderHistoryEvent, OrderHistoryState> {
  OrderHistoryBloc() : super(OrderHistoryInitial()) {
    on<OrderHistoryLoad>((event, emit) async {
      Response response = await ApiService().fetchData('/api/v1/order');
      print(response);
    });
  }
}