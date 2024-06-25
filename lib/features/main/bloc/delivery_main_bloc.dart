import 'package:delivery_kam/models/address_api.dart';
import 'package:delivery_kam/models/order.dart';
import 'package:delivery_kam/services/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

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
          responseData = response.data;
          for (var i = 0; i < responseData.length; i++) {
            addressess.add(AddressApi.fromJson(responseData[i]));
          }
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
      emit(DeliveryMainLoading());

      Map<String, dynamic> dataToSend = event.order.toJson();
      Response response =
          await ApiService().postData('/api/v1/order/price', dataToSend);
      if (response.statusCode == 200) {
        if (response.statusCode == 200) {
          OrderPrice data = OrderPrice.fromJson(response.data);

          List<LatLng> polylineCoordinates = [];
          PolylinePoints polylinePoints = PolylinePoints();
          List<PointLatLng> polylinePointsResult =
              polylinePoints.decodePolyline(data.routes[0].geometry);
          for (var element in polylinePointsResult) {
            polylineCoordinates
                .add(LatLng(element.latitude, element.longitude));
          }

          emit(DeliveryMainOrderPriceSuccess(
            orderPrice: data,
            polylineCoordinates: polylineCoordinates,
          ));
        }
      }
    });
    on<OrderCreateLoading>((event, emit) async {
      emit(DeliveryMainLoading());
      Map<String, dynamic> dataToSend = event.order.toJson();

      Response response =
          await ApiService().postData('/api/v1/order', dataToSend);
      if (response.statusCode == 201) {
        Order order = Order.fromJson(response.data);
        emit(DeliveryMainOrderCreateSuccess(order: order));
      }
    });
  }
}
