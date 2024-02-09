part of 'delivery_auth_register_bloc.dart';

class DeliveryAuthRegisterEvent {}

class LoadingRegisterRequest extends DeliveryAuthRegisterEvent {
  LoadingRegisterRequest(this.name, this.phone);
  final String name;
  final String phone;
}

class EditingPhoneNumber extends DeliveryAuthRegisterEvent {
  EditingPhoneNumber(this.name, this.phone);
  final String name;
  final String phone;
}
