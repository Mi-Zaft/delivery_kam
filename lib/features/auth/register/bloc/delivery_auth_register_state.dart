part of 'delivery_auth_register_bloc.dart';

class DeliveryAuthRegisterState {}

class DeliveryAuthRegisterInitial extends DeliveryAuthRegisterState {}

class DeliveryAuthRegisterSuccess extends DeliveryAuthRegisterState {}

class DeliveryAuthRegisterFail extends DeliveryAuthRegisterState {
  DeliveryAuthRegisterFail({required this.errorText});

  final String errorText;
}
