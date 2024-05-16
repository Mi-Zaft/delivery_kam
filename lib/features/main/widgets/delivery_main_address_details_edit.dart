import 'package:delivery_kam/features/main/widgets/delivery_address_textfield_custom.dart';
import 'package:delivery_kam/models/address_api.dart';
import 'package:flutter/material.dart';

class DeliveryMainAddressDetailsEdit extends StatefulWidget {
  const DeliveryMainAddressDetailsEdit({
    Key? key,
    required this.addressPostAllList,
  }) : super(key: key);

  final List<AddressPost> addressPostAllList;

  @override
  State<DeliveryMainAddressDetailsEdit> createState() =>
      _DeliveryMainAddressDetailsEditState();
}

class _DeliveryMainAddressDetailsEditState
    extends State<DeliveryMainAddressDetailsEdit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      margin: const EdgeInsets.only(top: 60),
      width: double.infinity,
        child: ListView.builder(
          itemCount: widget.addressPostAllList.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 16)
                      .copyWith(top: 15, bottom: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, .25),
                        spreadRadius: 1,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.addressPostAllList[index].addressRow,
                            textAlign: TextAlign.left,
                            maxLines: null,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        thickness: 1.5,
                        color: Color(0xff707070),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: DeliveryAddressTextfieldCustom(
                              labelText: 'Подъезд',
                              controller: TextEditingController(),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: DeliveryAddressTextfieldCustom(
                              labelText: 'Этаж',
                              controller: TextEditingController(),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: DeliveryAddressTextfieldCustom(
                              labelText: 'Квартира',
                              controller: TextEditingController(),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      DeliveryAddressTextfieldCustom(
                        labelText: 'Комментарий',
                        controller: TextEditingController(),
                        keyboardType: TextInputType.text,
                      ),
                      DeliveryAddressTextfieldCustom(
                        labelText: 'Номер телефона',
                        controller: TextEditingController(),
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}