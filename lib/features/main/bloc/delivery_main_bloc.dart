import 'package:delivery_kam/models/address_api.dart';
import 'package:delivery_kam/models/order.dart';
import 'package:delivery_kam/services/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'delivery_main_event.dart';
part 'delivery_main_state.dart';

class DeliveryMainBloc extends Bloc<DeliveryMainEvent, DeliveryMainState> {
  DeliveryMainBloc() : super(DeliveryMainInitial()) {
    // Loading main address hint request
    on<LoadingMainAddressHintRequest>((event, emit) async {
      Map<String, dynamic> dataToSend = {
        'name': event.address,
      };
      Response response =
          await ApiService().postData('/api/v1/geo/suggest', dataToSend);
      if (response.statusCode == 200) {
        List<AddressApi> addressess = [];
        List responseData;
        if (response.data is List) {
          if (response.data.length > 3) {
            responseData = response.data.sublist(0, 3);
            // emit(
            //   DeliveryMainAddressHintSuccess(
            //     addresses: response.data.sublist(0, 3),
            //   ),
            // );
          } else {
            responseData = response.data;
          }
          for (var i = 0; i < responseData.length; i++) {
            addressess.add(AddressApi.fromJson(responseData[i]));
          }
          print(addressess[0].fiasLevel);
          emit(
            DeliveryMainAddressHintSuccess(addresses: addressess),
          );
        }
      } else if (response.statusCode != 200) {
        emit(DeliveryMainAddressHintFail(
            errorText: response.statusMessage ?? 'Ошибка'));
      }
    });
    // Exit from account
    on<LoadingExitFromAccount>((event, emit) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('jwt_token');
    });
    on<OrderDataChanged>((event, emit) async {
      emit(DeliveryMainOrderPriceLoading());
      Map<String, dynamic> dataToSend = {
        'fromFiasId': event.order.fromFiasId,
        'whereFiasId': event.order.whereFiasId,
        'byCar': event.order.byCar
      };
      Response response = await ApiService().postData('/api/v1/order/price', dataToSend);
      if (response.statusCode == 200) {
        print(response);
        if (response.data is double) {
          emit(DeliveryMainOrderPriceSuccess(price: response.data));
        }
      }
    });
  }
}
