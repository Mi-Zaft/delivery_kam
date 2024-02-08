part of 'delivery_auth_confirm_code_bloc.dart';

class DeliveryAuthConfirmCodeEvent {}

class LoadingConfirmCodeRequest extends DeliveryAuthConfirmCodeEvent {
  LoadingConfirmCodeRequest(this.code, this.phone);
  final String code;
  final String phone;
}

class LoadingAuthConfirmCodeRequest extends DeliveryAuthConfirmCodeEvent {
  LoadingAuthConfirmCodeRequest(this.code, this.phone);
  final String code;
  final String phone;
}

class EditingCode extends DeliveryAuthConfirmCodeEvent {
  EditingCode(this.code);
  final String code;
}

class LoadingResendCode extends DeliveryAuthConfirmCodeEvent {
  LoadingResendCode(this.name, this.phone);
  final String? name;
  final String phone;
}
