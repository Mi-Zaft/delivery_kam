import 'package:delivery_kam/features/main/bloc/delivery_main_bloc.dart';
import 'package:delivery_kam/features/main/widgets/delivery_main_address_textfield_hint.dart';
import 'package:delivery_kam/models/address_api.dart';
import 'package:flutter/material.dart';

class AddressModalBottomSheet extends StatelessWidget {
  const AddressModalBottomSheet({
    super.key,
    required this.addressFromTextFieldController,
    required this.deliveryMainBloc,
    required this.onAddressReady,
    required this.labelText,
    required this.prefixText,
  });

  final TextEditingController addressFromTextFieldController;
  final DeliveryMainBloc deliveryMainBloc;
  final String labelText;
  final String prefixText;
  final Function(AddressApi) onAddressReady;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: DeliveryMainAddressTextfieldHint(
              textfieldController: addressFromTextFieldController,
              deliveryMainBloc: deliveryMainBloc,
              labelText: labelText,
              prefixText: prefixText,
              onTap: () {},
              onAddressReady: onAddressReady),
        ),
      ),
    );
  }
}
