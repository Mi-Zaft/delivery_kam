import 'package:delivery_kam/features/auth/choose/widgets/delivery_auth_choose_buttons.dart';
import 'package:flutter/material.dart';

class DeliveryAuthChooseScreen extends StatefulWidget {
  const DeliveryAuthChooseScreen({super.key});

  @override
  State<DeliveryAuthChooseScreen> createState() =>
      _DeliveryAuthChooseScreenState();
}

class _DeliveryAuthChooseScreenState extends State<DeliveryAuthChooseScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
              Color.fromRGBO(175, 223, 235, 1),
              Color.fromRGBO(121, 204, 219, 1),
              Color.fromRGBO(68, 82, 87, 1)
            ])),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset("assets/images/auth/logoText.png"),
            const DeliveryAuthChooseButtons()
          ],
        ),
      ),
    );
  }
}
