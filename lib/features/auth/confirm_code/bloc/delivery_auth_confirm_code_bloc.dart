import 'package:delivery_kam/models/user.dart';
import 'package:delivery_kam/services/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'delivery_auth_confirm_code_event.dart';
part 'delivery_auth_confirm_code_state.dart';

class DeliveryAuthConfirmCodeBloc
    extends Bloc<DeliveryAuthConfirmCodeEvent, DeliveryAuthConfirmCodeState> {
  DeliveryAuthConfirmCodeBloc() : super(DeliveryAuthConfirmCodeInitial()) {
    // Loading confirm code request
    on<LoadingConfirmCodeRequest>((event, emit) async {
      Map<String, dynamic> dataToSend = {
        'code': event.code,
        'phone': '+7${event.phone}',
      };
      Response response = await ApiService()
          .postData('/api/v1/registration/verify-code', dataToSend);
      if (response.statusCode == 200) {
        if (response.data['status'] == true) {
          if (response.data.containsKey('access_token')) {
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            await prefs.setString('jwt_token', response.data['access_token']);
            final fcmToken = prefs.getString('fcmToken');
            final Map<String, dynamic> fcmDataToSend = {'token': fcmToken};
            await ApiService()
                .postData('/api/v1/notification/token', fcmDataToSend);
            if (response.data.containsKey('name')) {
              User().name = response.data['name'];
              await prefs.setString('name', response.data['name']);
            }
            emit(DeliveryAuthConfirmCodeSuccess());
          } else {
            emit(DeliveryAuthConfirmCodeFail(errorText: 'Попробуйте еще раз'));
          }
        }
      } else {
        emit(DeliveryAuthConfirmCodeFail(
            errorText: response.statusMessage ?? 'Ошибка'));
      }
    });
    // Loading resend code
    on<LoadingResendCode>((event, emit) async {
      Map<String, dynamic> dataToSend = {
        'name': event.name,
        'phone': '+7${event.phone}'
      };
      if (event.name != null) {
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
      } else {
        Response response = await ApiService()
            .postData('/api/v1/authorization/send-code', dataToSend);
        if (response.statusCode == 200) {
          if (response.data['status'] == true) {
            emit(DeliveryAuthConfirmCodeResendSuccess());
          }
        } else {
          emit(DeliveryAuthConfirmCodeResendFail(
              errorText: response.statusMessage ?? 'Ошибка'));
        }
      }
    });
    // Loading auth confirm code request
    on<LoadingAuthConfirmCodeRequest>((event, emit) async {
      Map<String, dynamic> dataToSend = {
        'code': event.code,
        'phone': '+7${event.phone}',
      };
      Response response = await ApiService()
          .postData('/api/v1/authorization/verify-code', dataToSend);
      if (response.statusCode == 200) {
        if (response.data['status'] == true) {
          if (response.data.containsKey('access_token')) {
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            await prefs.setString('jwt_token', response.data['access_token']);
            final fcmToken = prefs.getString('fcmToken');
            final Map<String, dynamic> fcmDataToSend = {'token': fcmToken};
            await ApiService()
                .postData('/api/v1/notification/token', fcmDataToSend);
            if (response.data.containsKey('name')) {
              User().name = response.data['name'];
              await prefs.setString('name', response.data['name']);
            }
            emit(DeliveryAuthConfirmCodeSuccess());
          } else {
            emit(DeliveryAuthConfirmCodeFail(errorText: 'Попробуйте еще раз.'));
          }
        }
      } else {
        emit(DeliveryAuthConfirmCodeFail(
            errorText: response.statusMessage ?? 'Ошибка'));
      }
    });
    // editing code
    on<EditingCode>(
      (event, emit) async {
        if (state is DeliveryAuthConfirmCodeFail) {
          emit(DeliveryAuthConfirmCodeInitial());
        } else {
          if (event.code.length == 6) {
            emit(DeliveryAuthConfirmCodeWritten());
          } else {
            emit(DeliveryAuthConfirmCodeInitial());
          }
        }
      },
    );
  }
}
