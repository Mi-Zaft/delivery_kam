import 'package:flutter/material.dart';

class CourierMessage extends StatelessWidget {
  final String text;
  const CourierMessage({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          const SizedBox(
            width: 16,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            width: screenWidth * 0.7,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(196, 209, 212, 100),
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: Text(
              text,
              maxLines: 3,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
