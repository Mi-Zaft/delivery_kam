import 'package:delivery_kam/services/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

part 'delivery_auth_register_event.dart';
part 'delivery_auth_register_state.dart';

class DeliveryAuthRegisterBloc
    extends Bloc<DeliveryAuthRegisterEvent, DeliveryAuthRegisterState> {
  DeliveryAuthRegisterBloc() : super(DeliveryAuthRegisterInitial()) {
    // Loading register request
    on<LoadingRegisterRequest>(
      (event, emit) async {
        Map<String, dynamic> dataToSend = {
          'name': event.name,
          'phone': '+7${event.phone}',
        };
        Response response = await ApiService()
            .postData('/api/v1/registration/send-code', dataToSend);
        if (response.statusCode == 200) {
          if (response.data['status'] == true) {
            emit(DeliveryAuthRegisterSuccess());
          }
        } else if (response.statusCode != 200) {
          emit(DeliveryAuthRegisterFail(
              errorText: response.statusMessage ?? 'Ошибка'));
        }
      },
    );
    // Editing phone number
    on<EditingPhoneNumber>(
      (event, emit) async {
        if (state is DeliveryAuthRegisterFail) {
          emit(DeliveryAuthRegisterInitial());
        } else {
          if (event.phone.length == 16 && event.name.length >= 2) {
            emit(DeliveryAuthRegisterDataCorrect());
          } else {
            emit(DeliveryAuthRegisterInitial());
          }
        }
      },
    );
  }
}
