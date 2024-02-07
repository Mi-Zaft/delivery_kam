import 'package:delivery_kam/features/auth/choose/view/view.dart';
import 'package:delivery_kam/features/main/view/view.dart';
import 'package:delivery_kam/services/api_service.dart';
import 'package:flutter/material.dart';

class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ApiService().getToken(), // Получение токена
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError || snapshot.data == null) {
              return const DeliveryAuthChooseScreen();
            } else {
              return const DeliveryMainScreen();
            }
          }
          return const DeliveryAuthChooseScreen();
        });
  }
}
