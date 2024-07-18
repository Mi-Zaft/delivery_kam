import 'package:delivery_kam/services/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'support_event.dart';
part 'support_state.dart';

class SupportBloc extends Bloc<SupportEvent, SupportState> {
  SupportBloc() : super(SupportInitial()) {
    on<SupportMessageSend>((event, emit) async {
      Map<String, dynamic> dataToSend = {
        'text': event.text,
      };
      Response response =
          await ApiService().postData('/api/v1/support', dataToSend);
      emit(SupportLoading());
      if (response.statusCode == 200) {
        emit(SupportMessageSendSuccess());
      }
    });
  }
}
