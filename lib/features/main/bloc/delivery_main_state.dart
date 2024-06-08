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

class DeliveryMainLoading extends DeliveryMainState {}

class DeliveryMainOrderPriceSuccess extends DeliveryMainState {
  DeliveryMainOrderPriceSuccess({required this.orderPrice});

  final OrderPrice orderPrice;
}

class DeliveryMainOrderCreateSuccess extends DeliveryMainState {
  DeliveryMainOrderCreateSuccess({required this.order});

  final Order order;
}
