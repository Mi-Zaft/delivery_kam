import 'package:flutter_bloc/flutter_bloc.dart';

part 'order_active_event.dart';
part 'order_active_state.dart';

class OrderActiveBloc extends Bloc<OrderActiveEvent, OrderActiveState> {
  OrderActiveBloc() : super(OrderActiveInitial()) {
    on<OrderActiveLoad>((event, emit) async {});
  }
}
