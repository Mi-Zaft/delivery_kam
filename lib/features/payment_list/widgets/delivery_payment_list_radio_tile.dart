import 'package:flutter/material.dart';

class DeliveryPaymentListRadioTile extends StatelessWidget {
  final Image? leadingImage;
  final String title;
  final bool? active;
  final Function() onTap;
  const DeliveryPaymentListRadioTile(
      {super.key,
      required this.title,
      required this.onTap,
      this.leadingImage,
      this.active});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.only(top: 12)),
            Row(
              children: [
                if (leadingImage != null) leadingImage!,
                const Padding(padding: EdgeInsets.only(left: 15)),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                        fontFamily: "GT-Eesti-Pro-Display",
                        fontWeight: FontWeight.w300,
                        fontSize: 20),
                  ),
                ),
                if (active != true)
                  Container(
                    width: 25.0,
                    height: 25.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(238, 238, 238, 1),
                    ),
                  ),
                if (active == true)
                  Container(
                    width: 25.0,
                    height: 25.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(211, 229, 236, 1),
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Color.fromRGBO(110, 190, 206, 1),
                    ),
                  ),
                const Padding(
                  padding: EdgeInsets.only(right: 4),
                )
              ],
            ),
            const Padding(padding: EdgeInsets.only(bottom: 12)),
            const Divider(
              height: 20,
              thickness: 1,
              color: Color.fromRGBO(112, 112, 112, 1),
            ),
          ],
        ),
      ),
    );
  }
}
