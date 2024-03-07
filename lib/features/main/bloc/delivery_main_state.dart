part of 'delivery_main_bloc.dart';

class DeliveryMainState {}

class DeliveryMainInitial extends DeliveryMainState {}

class DeliveryMainAddressHintSuccess extends DeliveryMainState {
  DeliveryMainAddressHintSuccess({required this.addresses});
  final List<AddressApi> addresses;
}

class DeliveryMainAddressHintFail extends DeliveryMainState {
  DeliveryMainAddressHintFail({required this.errorText});

  final String errorText;
}

class DeliveryMainOrderCreateFail extends DeliveryMainState {
  DeliveryMainOrderCreateFail({required this.errorText});

  final String errorText;
}
