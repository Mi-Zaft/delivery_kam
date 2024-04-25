import 'package:delivery_kam/features/main/bloc/delivery_main_bloc.dart';
import 'package:delivery_kam/features/main/widgets/delivery_main_address_hint.dart';
import 'package:delivery_kam/features/main/widgets/delivery_main_textfield_address.dart';
import 'package:delivery_kam/models/address_api.dart';
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
  const DeliveryMainAddressTextfieldHint(
      {super.key,
      required this.textfieldController,
      required this.deliveryMainBloc,
      required this.fieldName,
      required this.labelText,
      required this.onTap,
      this.prefixText});

  @override
  State<DeliveryMainAddressTextfieldHint> createState() =>
      _DeliveryMainAddressTextfieldHintState();
}

class _DeliveryMainAddressTextfieldHintState
    extends State<DeliveryMainAddressTextfieldHint> {
  late bool isShowSuggest;
  FocusNode textfieldFocusNode = FocusNode();

  AddressApi toWhereObjext = AddressApi(city: '', street: '');

  @override
  void initState() {
    super.initState();
    textfieldFocusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {
      isShowSuggest = textfieldFocusNode.hasPrimaryFocus;
    });
  }

  @override
  void dispose() {
    textfieldFocusNode.removeListener(_onFocusChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AddressApi fromWhereObject;
    return Column(
      children: [
        DeliveryMainTextfieldAddress(
          textfieldFocusNode: textfieldFocusNode,
          onTap: () {
            setState(() {
              isShowSuggest = true;
            });
            widget.onTap();
          },
          onEditingComplete: () {
            FocusScope.of(context).unfocus();
          },
          onChange: () {
            setState(() {
              isShowSuggest = false;
            });
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
          },
          labelText: widget.labelText,
          prefixStyle: const TextStyle(
            fontSize: 20,
            color: Color.fromRGBO(122, 122, 122, 1),
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
              if (textfieldFocusNode.hasFocus) {
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
            } else {
              return const SizedBox.shrink();
            }
          },
        )
      ],
    );
  }
}
