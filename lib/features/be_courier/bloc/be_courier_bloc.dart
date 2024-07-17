import 'package:delivery_kam/services/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'be_courier_event.dart';
part 'be_courier_state.dart';

class BeCourierBloc extends Bloc<BeCourierEvent, BeCourierState> {
  BeCourierBloc() : super(BeCourierInitial()) {
    on<BeCourierTapped>((event, emit) async {
      Response response = await ApiService().postData('/api/v1/courier', '');
      emit(BeCourierLoading());
      if (response.statusCode == 200) {
        emit(BeCourierSuccess());
      }
    });
  }
}