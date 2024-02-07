import 'package:delivery_kam/services/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'delivery_auth_confirm_code_event.dart';
part 'delivery_auth_confirm_code_state.dart';

class DeliveryAuthConfirmCodeBloc
    extends Bloc<DeliveryAuthConfirmCodeEvent, DeliveryAuthConfirmCodeState> {
  final storage = const FlutterSecureStorage();
  DeliveryAuthConfirmCodeBloc() : super(DeliveryAuthConfirmCodeInitial()) {
    on<LoadingConfirmCodeRequest>((event, emit) async {
      Map<String, dynamic> dataToSend = {
        'code': event.code,
        'phone': '+7${event.phone}',
      };
      print(event.code);
      print(event.phone);
      Response response = await ApiService()
          .postData('/api/v1/registration/verify-code', dataToSend);
      if (response.statusCode == 200) {
        if (response.data['status'] == true) {
          print('Тип переменной: ${response.data.runtimeType}');
          if (response.data.containsKey('access_token')) {
            print(response.data['access_token']);
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            await prefs.setString('jwt_token', response.data['access_token']);
            emit(DeliveryAuthConfirmCodeSuccess());
          } else {
            emit(DeliveryAuthConfirmCodeFail(errorText: 'Попробуйте еще раз'));
          }
        }
      } else {
        print('ERROR');
        emit(DeliveryAuthConfirmCodeFail(
            errorText: response.statusMessage ?? 'Ошибка'));
      }
    });
    on<LoadingResendCode>((event, emit) async {
      Map<String, dynamic> dataToSend = {
        'name': event.name,
        'phone': '+7${event.phone}'
      };
      Response response = await ApiService()
          .postData('/api/v1/registration/send-code', dataToSend);
      if (response.statusCode == 200) {
        if (response.data['status'] == true) {
          emit(DeliveryAuthConfirmCodeResendSuccess());
        }
      } else {
        emit(DeliveryAuthConfirmCodeResendFail(
            errorText: response.statusMessage ?? 'Ошибка'));
      }
    });
    on<EditingCode>((event, emit) async {
      if (state is DeliveryAuthConfirmCodeFail) {
        emit(DeliveryAuthConfirmCodeInitial());
      } else {
        if (event.code.length == 6) {
          emit(DeliveryAuthConfirmCodeWritten());
        } else {
          emit(DeliveryAuthConfirmCodeInitial());
        }
      }
    });
  }
}
