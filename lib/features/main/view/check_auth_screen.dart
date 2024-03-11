import 'package:delivery_kam/features/auth/choose/view/view.dart';
import 'package:delivery_kam/features/main/view/view.dart';
import 'package:delivery_kam/models/user.dart';
import 'package:delivery_kam/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: ApiService().getToken(), // Получение токена
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError || snapshot.data == null) {
            return const DeliveryAuthChooseScreen();
          } else {
            return _buildMainScreen();
          }
        }
        return const DeliveryAuthChooseScreen();
      },
    );
  }

  Widget _buildMainScreen() {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final prefs = snapshot.data;
          if (prefs != null) {
            if (prefs.containsKey('name')) {
              User().name = prefs.getString('name');
            }
            return const DeliveryMainScreen();
          }
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
