import 'package:delivery_kam/services/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'order_active_event.dart';
part 'order_active_state.dart';

class OrderActiveBloc extends Bloc<OrderActiveEvent, OrderActiveState> {
  OrderActiveBloc() : super(OrderActiveInitial()) {
    on<OrderActiveLoad>((event, emit) async {});
    on<OrderActiveCancel>((event, emit) async {
      emit(OrderActiveCancelLoading());

      Map<String, dynamic> dataToSend = {
        'id': event.orderId
      };
      Response response = await ApiService().postData('/api/v1/order/cancel', dataToSend);
      if (response.statusCode == 200) {
        emit(OrderActiveCancelSuccess());
      }
    });
  }
}
