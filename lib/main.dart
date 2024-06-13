import 'package:delivery_kam/delivery_kam_app.dart';
import 'package:delivery_kam/firebase_api.dart';
import 'package:delivery_kam/firebase_options.dart';
import 'package:delivery_kam/services/api_service.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotifications();

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final fcmToken = prefs.getString('fcmToken');
  if (fcmToken != null) {
    final Map<String, dynamic> fcmDataToSend = {'token': fcmToken};
    Response fcmResponse = await ApiService()
        .postData('/api/v1/notification/token', fcmDataToSend);
    print('Set fcm token result: $fcmResponse');
  }

  runApp(const DeliveryKamApp());
}
