import 'package:flutter/material.dart';

class DeliveryPaymentListScreen extends StatefulWidget {
  const DeliveryPaymentListScreen({super.key});

  @override
  State<DeliveryPaymentListScreen> createState() =>
      _DeliveryPaymentListScreenState();
}

class _DeliveryPaymentListScreenState extends State<DeliveryPaymentListScreen> {
  String _character = 'cash';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Способы оплаты'),
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          children: [
            RadioListTile(
              groupValue: _character,
              controlAffinity: ListTileControlAffinity.trailing,
              onChanged: (String? value) {
                setState(() {
                  _character = 'cash';
                });
              },
              value: 'cash',
              title: Row(
                children: [
                  Image.asset('assets/images/payment/iconMoney.png'),
                  const Padding(padding: EdgeInsets.only(right: 15)),
                  const Text(
                    'Наличные',
                    style: TextStyle(
                        fontFamily: "GT-Eesti-Pro-Display",
                        fontWeight: FontWeight.w300,
                        fontSize: 20),
                  )
                ],
              ),
            ),
            RadioListTile(
              groupValue: _character,
              controlAffinity: ListTileControlAffinity.trailing,
              onChanged: (String? value) {
                setState(() {
                  _character = 'card';
                });
              },
              value: 'card',
              title: Row(
                children: [
                  Image.asset('assets/images/payment/iconCard.png'),
                  const Padding(padding: EdgeInsets.only(right: 15)),
                  const Text(
                    'Карта ···· 4605',
                    style: TextStyle(
                        fontFamily: "GT-Eesti-Pro-Display",
                        fontWeight: FontWeight.w300,
                        fontSize: 20),
                  ),
                ],
              ),
            )
            // ListTile(
            //   title: const Text(
            //     'Наличные',
            //     style: TextStyle(
            //         fontFamily: "GT-Eesti-Pro-Display",
            //         fontWeight: FontWeight.w300,
            //         fontSize: 20),
            //   ),
            //   leading: Image.asset('assets/images/payment/iconMoney.png'),
            // )
          ],
        ),
      ),
    );
  }
}
