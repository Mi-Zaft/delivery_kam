import 'package:delivery_kam/router/router.dart';
import 'package:delivery_kam/theme/theme.dart';
import 'package:flutter/material.dart';

class DeliveryKamApp extends StatelessWidget {
  const DeliveryKamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Delivery Kam',
      theme: classicTheme,
      routes: routes,
    );
  }
}
