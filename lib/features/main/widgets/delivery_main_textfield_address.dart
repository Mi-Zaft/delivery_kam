import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class DeliveryMainTextfieldAddress extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? prefixText;
  final Image? prefixIcon;
  final TextStyle? prefixStyle;
  final List<MaskTextInputFormatter>? maskInputFormatters;
  final Function onChange;
  final Function onEditingComplete;
  final Function onTap;
  final FocusNode textfieldFocusNode;

  final double columnHorizontalPadding = 24.0; // Отступы по бокам

  const DeliveryMainTextfieldAddress({
    Key? key,
    required this.labelText,
    required this.controller,
    required this.keyboardType,
    required this.onChange,
    required this.onEditingComplete,
    required this.onTap,
    required this.textfieldFocusNode,
    this.prefixText,
    this.prefixStyle,
    this.maskInputFormatters,
    this.prefixIcon,
  }) : super(key: key);

  @override
  DeliveryMainTextfieldAddressState createState() =>
      DeliveryMainTextfieldAddressState();
}

class DeliveryMainTextfieldAddressState
    extends State<DeliveryMainTextfieldAddress> {
  bool readOnly = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.columnHorizontalPadding),
      child: Column(
        children: [
          Center(
            child: Container(
              decoration:
                  const BoxDecoration(border: Border(bottom: BorderSide())),
              child: Row(
                children: [
                  if (widget.prefixText != null)
                    RichText(
                      text: TextSpan(
                        text: widget.prefixText,
                        style: widget.prefixStyle?.copyWith(
                          height: 2,
                        ),
                      ),
                    ),
                  if (widget.prefixIcon != null)
                    SizedBox(
                      width: 30,
                      height: 30,
                      child: widget.prefixIcon,
                    ),
                  const SizedBox(width: 5.0),
                  Flexible(
                    child: TextField(
                      readOnly: readOnly,
                      focusNode: widget.textfieldFocusNode,
                      onTapOutside: (event) => {
                        // widget.onEditingComplete()
                      },
                      cursorColor: Colors.black,
                      onTap: () {
                        widget.onTap();
                        FocusScope.of(context).requestFocus();
                      },
                      onEditingComplete: () {
                        setState(() {
                          readOnly = true;
                        });
                        widget.onEditingComplete();
                      },
                      inputFormatters: widget.maskInputFormatters,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                      textAlignVertical: const TextAlignVertical(y: 0),
                      keyboardType: widget.keyboardType,
                      decoration: InputDecoration(
                        prefixIconConstraints: const BoxConstraints(
                            minWidth: 20,
                            minHeight: 20,
                            maxWidth: 30,
                            maxHeight: 30),
                        isDense: true,
                        labelText: widget.labelText,
                        alignLabelWithHint: true,
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        contentPadding: EdgeInsets.only(
                            bottom: 10,
                            left: widget.prefixIcon != null ? 10 : 0),
                        labelStyle: const TextStyle(
                          color: Color.fromRGBO(122, 122, 122, 1),
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
                        setState(() => widget.onChange());
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
