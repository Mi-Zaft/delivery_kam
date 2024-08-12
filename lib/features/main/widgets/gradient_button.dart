import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GradientButton extends StatelessWidget {
  VoidCallback onPressed;
  String label;
  bool? disabled;
  GradientButton(
      {super.key, required this.onPressed, required this.label, this.disabled});

  @override
  Widget build(BuildContext context) {
    const activeColors = [
      Color.fromRGBO(175, 223, 234, 1),
      Color.fromRGBO(33, 190, 210, 1)
    ];

    const disableColors = [
      Color.fromRGBO(195, 195, 195, 1),
      Color.fromRGBO(195, 195, 195, 1)
    ];
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: disabled != null && disabled! == true ? disableColors : activeColors,
        ),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: ElevatedButton(
        onPressed: disabled != null && disabled == true ? () {} : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              Colors.transparent, // Чтобы фон ElevatedButton был прозрачным
          elevation: 0, // Отключаем подъем тени кнопки
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
