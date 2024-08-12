part of 'delivery_auth_login_bloc.dart';

class DeliveryAuthLoginState {}

class DeliveryAuthLoginInitial extends DeliveryAuthLoginState {}

class DeliveryAuthLoginSuccess extends DeliveryAuthLoginState {}

class DeliveryAuthLoginNumberIsCorrect extends DeliveryAuthLoginState {}

class DeliveryAuthLoading extends DeliveryAuthLoginState {}

class DeliveryAuthLoginFail extends DeliveryAuthLoginState {
  DeliveryAuthLoginFail({required this.errorText});

  final String errorText;
}
