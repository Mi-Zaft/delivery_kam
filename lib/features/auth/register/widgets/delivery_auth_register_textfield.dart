import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DeliveryAuthRegisterTextfield extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final String? prefixText;

  const DeliveryAuthRegisterTextfield({
    Key? key,
    required this.labelText,
    required this.controller,
    required this.keyboardType,
    required this.textCapitalization,
    this.inputFormatters,
    this.prefixText,
  }) : super(key: key);

  @override
  _DeliveryAuthRegisterTextfieldState createState() =>
      _DeliveryAuthRegisterTextfieldState();
}

class _DeliveryAuthRegisterTextfieldState
    extends State<DeliveryAuthRegisterTextfield> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextField(
        style: const TextStyle(
          fontSize: 18,
          fontFamily: "GT-Eesti-Pro-Display",
          fontWeight: FontWeight.w300,
        ),
        keyboardType: widget.keyboardType,
        textCapitalization: widget.textCapitalization,
        inputFormatters: widget.inputFormatters,
        decoration: InputDecoration(
          prefixText: widget.prefixText,
          labelText: widget.controller.text.isEmpty ? widget.labelText : null,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          contentPadding: const EdgeInsets.only(bottom: 0),
          labelStyle: const TextStyle(
            color: Colors.black,
            fontFamily: "GT-Eesti-Pro-Display",
            fontSize: 18,
            fontWeight: FontWeight.w300,
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
        controller: widget.controller,
        onChanged: (value) {
          setState(() {
            // Логика обновления состояния
          });
        },
      ),
    );
  }
}
