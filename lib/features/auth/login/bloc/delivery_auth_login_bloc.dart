import 'package:delivery_kam/services/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'delivery_auth_login_event.dart';
part 'delivery_auth_login_state.dart';

class DeliveryAuthLoginBloc
    extends Bloc<DeliveryAuthLoginEvent, DeliveryAuthLoginState> {
  DeliveryAuthLoginBloc() : super(DeliveryAuthLoginInitial()) {
    on<LoadingLoginRequest>((event, emit) async {
      Map<String, dynamic> dataToSend = {
        'phone': '+7${event.phone}',
      };
      Response response = await ApiService()
          .postData('/api/v1/authorization/send-code', dataToSend);
      if (response.statusCode == 200) {
        if (response.data['status'] == true) {
          emit(DeliveryAuthLoginSuccess());
        }
      } else if (response.statusCode != 200) {
        emit(DeliveryAuthLoginFail(
            errorText: response.statusMessage ?? 'Ошибка'));
      }
    });
  }
}
