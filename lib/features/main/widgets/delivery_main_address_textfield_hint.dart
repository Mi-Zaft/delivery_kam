import 'package:delivery_kam/features/main/bloc/delivery_main_bloc.dart';
import 'package:delivery_kam/features/main/widgets/delivery_main_address_hint.dart';
import 'package:delivery_kam/features/main/widgets/delivery_main_textfield_address.dart';
import 'package:delivery_kam/models/address_api.dart';
import 'package:flutter/material.dart';
// import 'package:delivery_kam/models/order.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeliveryMainAddressTextfieldHint extends StatefulWidget {
  final TextEditingController textfieldController;
  final DeliveryMainBloc deliveryMainBloc;
  final String fieldName;
  final String labelText;
  final String? prefixText;
  final Function onTap;
  final Function(AddressApi) onAddressReady;
  const DeliveryMainAddressTextfieldHint(
      {super.key,
      required this.textfieldController,
      required this.deliveryMainBloc,
      required this.fieldName,
      required this.labelText,
      required this.onTap,
      this.prefixText,
      required this.onAddressReady});

  @override
  State<DeliveryMainAddressTextfieldHint> createState() =>
      _DeliveryMainAddressTextfieldHintState();
}

class _DeliveryMainAddressTextfieldHintState
    extends State<DeliveryMainAddressTextfieldHint> {
  @override
  void initState() {
    super.initState();
    textfieldFocusNode.requestFocus();
    onAddressUpdated();
  }

  bool isShowSuggest = false;
  FocusNode textfieldFocusNode = FocusNode();

  AddressApi toWhereObjext = AddressApi(city: '', street: '');

  @override
  Widget build(BuildContext context) {
    AddressApi fromWhereObject;
    return Column(
      children: [
        DeliveryMainTextfieldAddress(
          textfieldFocusNode: textfieldFocusNode,
          onTap: () {
            widget.onTap();
            onAddressUpdated();
          },
          onEditingComplete: () {
            FocusScope.of(context).unfocus();
          },
          onChange: () {
            setState(() {
              isShowSuggest = false;
            });
            onAddressUpdated();
          },
          labelText: widget.labelText,
          prefixStyle: const TextStyle(
            fontSize: 20,
            color: Color(0xff7A7A7A),
          ),
          controller: widget.textfieldController,
          keyboardType: TextInputType.streetAddress,
          prefixText: widget.prefixText,
        ),
        const SizedBox(
          height: 15,
        ),
        BlocBuilder<DeliveryMainBloc, DeliveryMainState>(
          bloc: widget.deliveryMainBloc,
          builder: (context, state) {
            if (state is DeliveryMainAddressHintSuccess &&
                state.fieldName == widget.fieldName &&
                isShowSuggest) {
              return ListView.builder(
                padding: const EdgeInsets.all(0),
                itemCount: state.addresses.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext listContext, int index) {
                  return DeliveryMainAddressHint(
                    onClick: (address) {
                      widget.textfieldController.text =
                          "${address.city} ${address.street} ${address.house ?? ''}";
                      fromWhereObject = address;
                      if (address.fiasLevel != null) {
                        if (address.fiasLevel! >= 8) {
                          setState(() {
                            isShowSuggest = false;
                          });
                          print('qweqw');
                          widget.onAddressReady(address);
                          FocusScope.of(context).unfocus();
                          if (fromWhereObject.fiasId != null &&
                              toWhereObjext.fiasId != null) {
                            // order = Order(
                            //     fromFiasId: fromWhereObject.fiasId!,
                            //     whereFiasId: toWhereObjext.fiasId!,
                            //     byCar: _byCar);
                            // makeOrder();
                          }
                        }
                      }
                    },
                    address: state.addresses[index],
                  );
                },
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        )
      ],
    );
  }

  void onAddressUpdated() {
    if (widget.textfieldController.text.length >= 3) {
      setState(() {
        isShowSuggest = true;
      });
      widget.deliveryMainBloc.add(
        LoadingMainAddressHintRequest(
            widget.textfieldController.text, widget.fieldName),
      );
    } else {
      setState(() {
        isShowSuggest = false;
      });
    }
  }
}
