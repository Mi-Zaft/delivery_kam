import 'package:flutter/material.dart';

class DeliveryAuthChooseButtons extends StatefulWidget {
  const DeliveryAuthChooseButtons({super.key});

  @override
  State<DeliveryAuthChooseButtons> createState() =>
      _DeliveryAuthChooseButtonsState();
}

class _DeliveryAuthChooseButtonsState extends State<DeliveryAuthChooseButtons> {
  @override
  void initState() {
    super.initState();
  }

  final String loginButtonText = "Войти";
  final String registerButtonText = "Создать аккаунт";
  final double columnHorizontalPadding =
      24.0; // Отступы по бокам столбца кнопок
  final double buttonHeight = 15; // Высота кнопок

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: columnHorizontalPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("/register");
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: buttonHeight),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text(registerButtonText,
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontFamily: "GT-Eesti-Pro-Display",
                        fontWeight: FontWeight.w400)),
              )),
          const SizedBox(height: 16.0),
          SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  padding: EdgeInsets.symmetric(vertical: buttonHeight),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: const BorderSide(color: Colors.white, width: 2)),
                ),
                child: Text(loginButtonText,
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: "GT-Eesti-Pro-Display",
                        fontWeight: FontWeight.w400)),
              )),
          const SizedBox(height: 40.0),
        ],
      ),
    ));
  }
}
