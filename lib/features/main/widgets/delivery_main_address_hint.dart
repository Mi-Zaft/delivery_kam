import 'package:flutter/material.dart';

class DeliveryMainAddressHint extends StatelessWidget {
  final columnHorizontalPadding = 24.0;
  final String address;
  const DeliveryMainAddressHint({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color.fromRGBO(239, 239, 239, 1)),
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                    padding: EdgeInsets.only(left: columnHorizontalPadding)),
                Image.asset('assets/images/main/iconPoint.png'),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  address,
                  style: const TextStyle(
                    color: Color.fromRGBO(122, 122, 122, 1),
                    fontSize: 18,
                    fontFamily: "GT-Eesti-Pro-Display",
                    fontWeight: FontWeight.w300,
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                left: columnHorizontalPadding,
                right: columnHorizontalPadding,
                top: 5,
              ),
              child: const Divider(
                height: 1.5,
                color: Color.fromRGBO(112, 112, 112, 1),
              ),
            )
          ],
        ),
      ),
    );
  }
}
