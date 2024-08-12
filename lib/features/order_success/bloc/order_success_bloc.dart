import 'package:delivery_kam/models/order.dart';
import 'package:delivery_kam/services/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'order_success_event.dart';
part 'order_success_state.dart';

class OrderSuccessBloc extends Bloc<OrderSuccessEvent, OrderSuccessState> {
  OrderSuccessBloc() : super(OrderSuccessInitial()) {
    on<OrderSuccessEvent>((event, emit) {
      
    });
    on<OrderLoadById>((event, emit) async {
      Response response =
          await ApiService().fetchData('/api/v1/order/${event.orderId}');
      if (response.statusCode == 200) {
        Order order = Order.fromJson(response.data);
        emit(OrderSuccessLoaded(order: order));
      }
    });
    on<OrderSuccessCommentSend>((event, emit) async {
      emit(OrderSuccessCommentLoad());
      Map<String, dynamic> dataToSend = {
        'id': event.orderId,
        'comment': event.comment,
      };
      Response response =
          await ApiService().postData('/api/v1/order/comment', dataToSend);

      if (response.statusCode == 200) {
        if (response.data.runtimeType == String) {
          emit(OrderSuccessCommentSuccess(comment: response.data));
        } else {
          emit(OrderSuccessCommentSuccess(
              comment: 'Спасибо за ваш комментарий!'));
        }
      }
    });
  }
}
