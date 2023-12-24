import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class DeliveryAuthConfirmCodeTextfield extends StatefulWidget {
  const DeliveryAuthConfirmCodeTextfield({super.key});

  @override
  State<DeliveryAuthConfirmCodeTextfield> createState() =>
      _DeliveryAuthConfirmCodeTextfieldState();
}

class _DeliveryAuthConfirmCodeTextfieldState
    extends State<DeliveryAuthConfirmCodeTextfield> {
  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
        textAlign: TextAlign.center,
        showCursor: false,
        maxLength: 1,
        name: 'first',
        style: const TextStyle(
          fontSize: 48,
          fontFamily: "GT-Eesti-Pro-Display",
          fontWeight: FontWeight.w300,
        ),
        decoration: const InputDecoration(
            isCollapsed: true,
            counterText: "",
            contentPadding: EdgeInsets.zero,
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            )));
  }
}
