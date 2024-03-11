import 'package:delivery_kam/features/payment_list/widgets/delivery_payment_add_card_list_tile.dart';
import 'package:delivery_kam/features/payment_list/widgets/delivery_payment_list_radio_tile.dart';
import 'package:flutter/material.dart';

class DeliveryPaymentListScreen extends StatefulWidget {
  const DeliveryPaymentListScreen({super.key});

  @override
  State<DeliveryPaymentListScreen> createState() =>
      _DeliveryPaymentListScreenState();
}

class _DeliveryPaymentListScreenState extends State<DeliveryPaymentListScreen> {
  String _paymentMethod = 'cash';

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
            const Padding(padding: EdgeInsets.only(top: 35)),
            DeliveryPaymentListRadioTile(
              onTap: () => {
                updateSelectedTile('cash'),
              },
              leadingImage: Image.asset('assets/images/payment/iconMoney.png'),
              title: 'Наличные',
              active: _paymentMethod == 'cash',
            ),
            // DeliveryPaymentListRadioTile(
            //   onTap: () => {
            //     updateSelectedTile('4605'),
            //   },
            //   leadingImage: Image.asset('assets/images/payment/iconCard.png'),
            //   title: 'Карта ···· 4605',
            //   active: _paymentMethod == '4605',
            // ),
            const DeliveryPaymentAddCardListTile()
          ],
        ),
      ),
    );
  }

  void updateSelectedTile(String newValue) {
    setState(() {
      _paymentMethod = newValue;
    });
  }
}
