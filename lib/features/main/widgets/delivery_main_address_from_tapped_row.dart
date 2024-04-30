import 'package:delivery_kam/features/main/bloc/delivery_main_bloc.dart';
import 'package:delivery_kam/features/main/widgets/address_modal_bottom_sheet.dart';
import 'package:delivery_kam/models/address_api.dart';
import 'package:flutter/material.dart';

class DeliveryMainAddressFromTappedRow extends StatelessWidget {
  final String labelText;
  final String prefixText;
  final Function(AddressApi) onAddressReady;
  const DeliveryMainAddressFromTappedRow({
    super.key,
    required this.labelText,
    required this.prefixText,
    required this.onAddressReady,
  });

  @override
  Widget build(BuildContext context) {
    final deliveryMainBloc = DeliveryMainBloc();
    final TextEditingController addressFromTextFieldController =
        TextEditingController();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24).copyWith(top: 15),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (BuildContext context) {
                    return AddressModalBottomSheet(
                      addressFromTextFieldController:
                          addressFromTextFieldController,
                      deliveryMainBloc: deliveryMainBloc,
                      onAddressReady: (addressApi) {
                        onAddressReady(addressApi);
                        Navigator.pop(context);
                      },
                      labelText: labelText,
                      prefixText: prefixText,
                    );
                  });
            },
            child: Row(
              children: [
                Text(
                  prefixText,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: Color(0xff7A7A7A),
                  ),
                ),
                const SizedBox(width: 5.0),
                Expanded(
                  child: Text(
                    labelText,
                    maxLines: null,
                    style: const TextStyle(
                      color: Color(0xff7A7A7A),
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 1.5,
            color: Color(0xff707070),
          )
        ],
      ),
    );
  }
}
