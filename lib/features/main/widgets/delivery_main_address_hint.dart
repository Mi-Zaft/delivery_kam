import 'package:delivery_kam/models/address_api.dart';
import 'package:flutter/material.dart';

class DeliveryMainAddressHint extends StatelessWidget {
  final columnHorizontalPadding = 24.0;
  final AddressApi address;
  final Function(AddressApi) onClick;
  const DeliveryMainAddressHint(
      {super.key, required this.onClick, required this.address});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {onClick(address)},
      child: Container(
        height: 60,
        decoration:
            const BoxDecoration(color: Color.fromRGBO(239, 239, 239, 1)),
        child: Padding(
          padding: const EdgeInsets.only(top: 5),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${address.street} ${address.house ?? ''}",
                        style: const TextStyle(
                          color: Color(0xff7A7A7A),
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                          "${address.city}",
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            color: Color(0xff7A7A7A),
                            fontSize: 14,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                    ],
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
      ),
    );
  }
}
