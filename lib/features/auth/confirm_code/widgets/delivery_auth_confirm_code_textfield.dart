import 'package:flutter/material.dart';

class DeliveryAuthConfirmCodeTextField extends StatelessWidget {
  const DeliveryAuthConfirmCodeTextField({
    super.key,
    required this.onPressed,
    required this.value,
  });

  final VoidCallback onPressed;
  final String value;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onPressed,
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color.fromRGBO(112, 112, 112, 1),
              ),
            ),
          ),
          child: Center(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.w400,
                fontFamily: "GT-Eesti-Pro-Display",
              ),
            ),
          ),
        ),
      );
}
