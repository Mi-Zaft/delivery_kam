import 'package:flutter/material.dart';

class OrderActiveActionButton extends StatelessWidget {
  String imagePath;
  String label;
  OrderActiveActionButton({
    super.key,
    required this.imagePath,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.symmetric(horizontal: 17)
          .copyWith(top: 15)
          .copyWith(bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color.fromRGBO(195, 195, 195, 1),
          width: 3,
        ),
      ),
      child: Column(
        children: [
          Text(label),
          const Padding(
            padding: EdgeInsets.only(top: 10),
          ),
          Image.asset(
            imagePath,
            height: 50,
          ),
        ],
      ),
    );
  }
}
