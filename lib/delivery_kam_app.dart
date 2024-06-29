import 'package:delivery_kam/router/router.dart';
import 'package:delivery_kam/theme/theme.dart';
import 'package:flutter/material.dart';

class DeliveryKamApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  const DeliveryKamApp({super.key, required this.navigatorKey});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Delivery Kam',
      theme: classicTheme,
      navigatorKey: navigatorKey,
      routes: routes,
    );
  }
}
