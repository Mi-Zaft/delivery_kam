part of 'delivery_main_bloc.dart';

class DeliveryMainEvent {}

class LoadingMainAddressHintRequest extends DeliveryMainEvent {
  LoadingMainAddressHintRequest(this.address, this.fieldName);
  final String address;
  final String fieldName;
}

class LoadingExitFromAccount extends DeliveryMainEvent {
  LoadingExitFromAccount();
}

class OrderDataChanged extends DeliveryMainEvent {
  OrderDataChanged(this.order);
  Order order;
}

class OrderCreateLoading extends DeliveryMainEvent {
  OrderCreateLoading(this.order);
  Order order;
}
