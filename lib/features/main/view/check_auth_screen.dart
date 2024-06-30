import 'dart:convert';

import 'package:delivery_kam/features/auth/choose/view/view.dart';
import 'package:delivery_kam/features/main/view/view.dart';
import 'package:delivery_kam/features/order_active/view/order_active_screen.dart';
import 'package:delivery_kam/models/order.dart';
import 'package:delivery_kam/models/user.dart';
import 'package:delivery_kam/services/api_service.dart';
import 'package:dio/dio.dart';
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
            return FutureBuilder<Response?>(
              future: ApiService().fetchData(
                  '/api/v1/order/active'), // Получение актуального заказа
              builder: (context, orderSnapshot) {
                if (orderSnapshot.connectionState == ConnectionState.done) {
                  if (orderSnapshot.hasError || orderSnapshot.data == null) {
                    return const DeliveryMainScreen();
                  } else {
                    final response = orderSnapshot.data;
                    if (response != null && response.statusCode == 200) {
                      if (response.data != null) {
                        Order order = Order.fromJson(response.data);
                        return OrderActiveScreen(order: order);
                      }
                    }
                  }
                }
                return const DeliveryMainScreen();
                // return const CircularProgressIndicator();
              },
            );
            // return const DeliveryMainScreen();
          }
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
