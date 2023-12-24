import 'package:delivery_kam/features/auth/confirm_code/widgets/delivery_auth_confirm_code_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class DeliveryAuthConfirmCodeScreen extends StatefulWidget {
  const DeliveryAuthConfirmCodeScreen({Key? key}) : super(key: key);

  @override
  State<DeliveryAuthConfirmCodeScreen> createState() =>
      _DeliveryAuthConfirmCodeScreenState();
}

class _DeliveryAuthConfirmCodeScreenState
    extends State<DeliveryAuthConfirmCodeScreen> {
  final phoneNumber = "+7 999 630 92 16";
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Регистрация"),
        iconTheme: const IconThemeData(color: Color.fromRGBO(149, 149, 149, 1)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 25, top: 15),
              child: Text(
                "Введите полученный код",
                style: TextStyle(
                  color: Color.fromRGBO(122, 122, 122, 1),
                  fontFamily: "GT-Eesti-Pro-Display",
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, top: 15),
              child: Text(
                phoneNumber,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  color: Color.fromRGBO(122, 122, 122, 1),
                  fontFamily: "GT-Eesti-Pro-Display",
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(width: 24),
                Expanded(child: DeliveryAuthConfirmCodeTextfield()),
                const SizedBox(width: 5),
                Expanded(child: DeliveryAuthConfirmCodeTextfield()),
                const SizedBox(width: 5),
                Expanded(
                    child: Expanded(child: DeliveryAuthConfirmCodeTextfield())),
                const SizedBox(width: 5),
                Expanded(
                  child: Expanded(child: DeliveryAuthConfirmCodeTextfield()),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Expanded(child: DeliveryAuthConfirmCodeTextfield()),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Expanded(child: DeliveryAuthConfirmCodeTextfield()),
                ),
                const SizedBox(width: 24),
              ],
            ),
            const SizedBox(height: 10),
            Center(
                child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Отправить код повторно",
                      style: TextStyle(color: Color.fromRGBO(56, 144, 208, 1)),
                    ))),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
