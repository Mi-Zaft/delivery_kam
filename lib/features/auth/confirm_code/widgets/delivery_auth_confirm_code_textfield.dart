import 'package:delivery_kam/features/auth/confirm_code/bloc/delivery_auth_confirm_code_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class DeliveryAuthConfirmCodeTextfield extends StatefulWidget {
  const DeliveryAuthConfirmCodeTextfield(
      {super.key,
      required this.controller,
      required this.focusNode,
      required this.onChanged,
      required this.onTap,
      required this.isError});
  final TextEditingController controller;
  final FocusNode focusNode;
  final void Function(String?) onChanged;
  final bool isError;
  final void Function() onTap;

  @override
  State<DeliveryAuthConfirmCodeTextfield> createState() =>
      _DeliveryAuthConfirmCodeTextfieldState();
}

class _DeliveryAuthConfirmCodeTextfieldState
    extends State<DeliveryAuthConfirmCodeTextfield> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeliveryAuthConfirmCodeBloc,
        DeliveryAuthConfirmCodeState>(
      builder: (context, state) {
        if (state is DeliveryAuthConfirmCodeFail) {
          return FormBuilderTextField(
              textAlign: TextAlign.center,
              showCursor: false,
              maxLength: 1,
              onTap: widget.onTap,
              keyboardType: TextInputType.number,
              onChanged: widget.onChanged,
              controller: widget.controller,
              name: 'first',
              focusNode: widget.focusNode,
              style: const TextStyle(
                  fontSize: 48,
                  fontFamily: "GT-Eesti-Pro-Display",
                  fontWeight: FontWeight.w300,
                  color: Color.fromRGBO(255, 44, 44, 1)),
              decoration: const InputDecoration(
                  isCollapsed: true,
                  counterText: "",
                  contentPadding: EdgeInsets.zero,
                  filled: true,
                  fillColor: Color.fromRGBO(255, 136, 136, .5),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  )));
        } else {
          // Действия для других состояний, если они вам нужны
          return FormBuilderTextField(
              textAlign: TextAlign.center,
              showCursor: false,
              maxLength: 1,
              keyboardType: TextInputType.number,
              onChanged: widget.onChanged,
              controller: widget.controller,
              name: 'first',
              focusNode: widget.focusNode,
              style: const TextStyle(
                fontSize: 48,
                fontFamily: "GT-Eesti-Pro-Display",
                fontWeight: FontWeight.w300,
              ),
              decoration: const InputDecoration(
                  isCollapsed: true,
                  counterText: "",
                  contentPadding: EdgeInsets.zero,
                  filled: false,
                  fillColor:  Color.fromRGBO(255, 136, 136, .5),
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
      },
    );
  }
}
