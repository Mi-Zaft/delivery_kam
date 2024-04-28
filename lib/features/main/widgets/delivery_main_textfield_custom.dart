import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class DeliveryMainTextfieldCustom extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? prefixText;
  final Image? prefixIcon;
  final TextStyle? prefixStyle;
  final List<MaskTextInputFormatter>? maskInputFormatters;

  final double columnHorizontalPadding = 24.0; // Отступы по бокам

  const DeliveryMainTextfieldCustom(
      {Key? key,
      required this.labelText,
      required this.controller,
      required this.keyboardType,
      this.prefixText,
      this.prefixStyle,
      this.maskInputFormatters,
      this.prefixIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: columnHorizontalPadding),
      child: Center(
        child: Container(
          decoration: const BoxDecoration(border: Border(bottom: BorderSide())),
          child: Row(
            children: [
              if (prefixText != null)
                RichText(
                  text: TextSpan(
                    text: prefixText,
                    style: prefixStyle?.copyWith(
                      height: 2.2,
                    ),
                  ),
                ),
              if (prefixIcon != null)
                SizedBox(
                  width: 30,
                  height: 30,
                  child: prefixIcon,
                ),
              const SizedBox(width: 5.0),
              Expanded(
                child: TextField(
                  cursorColor: Colors.black,
                  inputFormatters: maskInputFormatters,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                  textAlignVertical: const TextAlignVertical(y: 0),
                  keyboardType: keyboardType,
                  decoration: InputDecoration(
                    prefixIconConstraints: const BoxConstraints(
                        minWidth: 20,
                        minHeight: 20,
                        maxWidth: 30,
                        maxHeight: 30),
                    isDense: true,
                    labelText: labelText,
                    alignLabelWithHint: true,
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    contentPadding: EdgeInsets.only(
                        bottom: 10, left: prefixIcon != null ? 10 : 0),
                    labelStyle: const TextStyle(
                      color: Color(0xff7A7A7A),
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0)),
                    ),
                    border: InputBorder.none,
                  ),
                  controller: controller,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
