import 'package:flutter/material.dart';

class OrderItem extends StatelessWidget {
  final String id;
  final String date;
  const OrderItem({super.key, required this.id, required this.date});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        child: Material(
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () => {print('tap')},
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(
                    color: const Color.fromRGBO(195, 195, 195, 1), width: 3),
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Center(
                child: Text(
                  date,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
