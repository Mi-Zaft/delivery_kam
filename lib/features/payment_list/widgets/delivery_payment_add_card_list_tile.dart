import 'package:flutter/material.dart';

class DeliveryPaymentAddCardListTile extends StatelessWidget {
  const DeliveryPaymentAddCardListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: InkWell(
        onTap: () => {Navigator.of(context).pushNamed('/payment-add')},
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.only(top: 12)),
            Row(
              children: [
                Image.asset('assets/images/payment/iconPlus.png'),
                const Padding(padding: EdgeInsets.only(left: 15)),
                const Expanded(
                  child: Text(
                    'Добавить карту',
                    style: TextStyle(
                        fontFamily: "GT-Eesti-Pro-Display",
                        fontWeight: FontWeight.w300,
                        fontSize: 20),
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Color.fromRGBO(149, 149, 149, 1),
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
