part of 'delivery_auth_login_bloc.dart';

class DeliveryAuthLoginEvent {}

class LoadingLoginRequest extends DeliveryAuthLoginEvent {
  LoadingLoginRequest(this.phone);
  final String phone;
}
