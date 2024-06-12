import 'package:delivery_kam/delivery_kam_app.dart';
import 'package:delivery_kam/firebase_api.dart';
import 'package:delivery_kam/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotifications();

  runApp(const DeliveryKamApp());
}
