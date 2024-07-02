import 'package:flutter/material.dart';

class OrderCancelReasonItem extends StatelessWidget {
  final Function() onTap;
  final Image leadingImage;
  final String title;
  final bool? active;
  const OrderCancelReasonItem({
    super.key,
    required this.onTap,
    required this.leadingImage,
    required this.title,
    this.active,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24)
            .copyWith(top: 10)
            .copyWith(bottom: 10),
        child: Row(
          children: [
            leadingImage,
            const Padding(padding: EdgeInsets.only(left: 15)),
            Expanded(
              child: Text(
                title,
                style:
                    const TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
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
      ),
    );
  }
}
