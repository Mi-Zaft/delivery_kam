import 'package:flutter/material.dart';

class DeliveryMainTextfieldAddress extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? prefixText;
  final Align? prefixIcon;

  const DeliveryMainTextfieldAddress(
      {Key? key,
      required this.labelText,
      required this.controller,
      required this.keyboardType,
      this.prefixText,
      this.prefixIcon})
      : super(key: key);

  @override
  _DeliveryMainTextfieldAddressState createState() =>
      _DeliveryMainTextfieldAddressState();
}

class _DeliveryMainTextfieldAddressState
    extends State<DeliveryMainTextfieldAddress> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            decoration:
                const BoxDecoration(border: Border(bottom: BorderSide())),
            child: Row(
              children: [
                Text(widget.prefixText ?? '',
                    style: const TextStyle(
                        fontSize: 20, color: Color.fromRGBO(122, 122, 122, 1))),
                const SizedBox(width: 5.0),
                Expanded(
                  child: TextField(
                    style: const TextStyle(
                      fontSize: 18,
                      fontFamily: "GT-Eesti-Pro-Display",
                      fontWeight: FontWeight.w300,
                    ),
                    keyboardType: widget.keyboardType,
                    decoration: InputDecoration(
                      labelText: widget.controller.text.isEmpty
                          ? widget.labelText
                          : null,
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      contentPadding: const EdgeInsets.only(bottom: 0),
                      labelStyle: const TextStyle(
                        color: Color.fromRGBO(122, 122, 122, 1),
                        fontFamily: "GT-Eesti-Pro-Display",
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromRGBO(0, 0, 0, 0)),
                      ),
                      border: InputBorder.none,
                    ),
                    controller: widget.controller,
                    onChanged: (value) {
                      setState(() {
                        // Логика обновления состояния
                      });
                    },
                  ),
                )
              ],
            )));
  }
}
