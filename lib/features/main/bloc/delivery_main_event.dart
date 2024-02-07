part of 'delivery_main_bloc.dart';

class DeliveryMainEvent {}

class LoadingMainAddressHintRequest extends DeliveryMainEvent {
  LoadingMainAddressHintRequest(this.address);
  final String address;
}
