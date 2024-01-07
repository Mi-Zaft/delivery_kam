part of 'delivery_auth_confirm_code_bloc.dart';

class DeliveryAuthConfirmCodeState {}

class DeliveryAuthConfirmCodeInitial extends DeliveryAuthConfirmCodeState {}

class DeliveryAuthConfirmCodeWritten extends DeliveryAuthConfirmCodeState {}

class DeliveryAuthConfirmCodeSuccess extends DeliveryAuthConfirmCodeState {}

class DeliveryAuthConfirmCodeFail extends DeliveryAuthConfirmCodeState {
  DeliveryAuthConfirmCodeFail({required this.errorText});

  final String errorText;
}

class DeliveryAuthConfirmCodeResendSuccess
    extends DeliveryAuthConfirmCodeState {}

class DeliveryAuthConfirmCodeResendFail extends DeliveryAuthConfirmCodeState {
  DeliveryAuthConfirmCodeResendFail({required this.errorText});
  final String errorText;
}
