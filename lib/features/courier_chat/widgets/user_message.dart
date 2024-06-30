import 'package:flutter/material.dart';

class UserMessage extends StatelessWidget {
  final String text;
  final String timeText;
  const UserMessage({
    super.key,
    required this.text,
    required this.timeText,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10)
                .copyWith(top: 10)
                .copyWith(bottom: 5),
            width: screenWidth * 0.7,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(204, 230, 237, 100),
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: Column(
              children: [
                Text(
                  text,
                  style: const TextStyle(fontSize: 16),
                ),
                Row(
                  children: [
                    const Spacer(),
                    Text(
                      timeText,
                      style: const TextStyle(
                        color: Color.fromRGBO(112, 112, 112, 1),
                        fontSize: 12,
                      ),
                    ),
                  ],
                )
              ],
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
