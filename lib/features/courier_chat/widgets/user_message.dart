import 'package:flutter/material.dart';

class UserMessage extends StatelessWidget {
  final String text;
  const UserMessage({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(10),
            width: screenWidth * 0.7,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(204, 230, 237, 100),
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: Text(
              text,
              maxLines: 3,
            ),
          ),
          const SizedBox(
            width: 16,
          )
        ],
      ),
    );
  }
}
