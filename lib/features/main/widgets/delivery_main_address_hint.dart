import 'package:delivery_kam/models/address_api.dart';
import 'package:flutter/material.dart';

class DeliveryMainAddressHint extends StatelessWidget {
  final AddressApi address;
  final Function(AddressApi) onClick;

  static const columnHorizontalPadding = 24.0;
  static const backgroundColor = Color.fromRGBO(239, 239, 239, 1);
  static const textColor = Color(0xff7A7A7A);
  static const dividerColor = Color.fromRGBO(112, 112, 112, 1);

  const DeliveryMainAddressHint({
    super.key,
    required this.onClick,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {onClick(address)},
      child: Container(
        // height: 60,
        decoration: const BoxDecoration(color: backgroundColor),
        child: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Row(
            children: [
              const Padding(
                  padding: EdgeInsets.only(left: columnHorizontalPadding)),
              Image.asset('assets/images/main/iconPoint.png'),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${address.street} ${address.house ?? ''}",
                      maxLines: null,
                      style: const TextStyle(
                        color: textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      "${address.city}",
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        color: textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                    const Divider(
                      height: 1.5,
                      color: dividerColor,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
