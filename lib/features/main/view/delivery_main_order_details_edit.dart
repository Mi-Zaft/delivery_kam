import 'package:delivery_kam/features/main/widgets/delivery_address_textfield_custom.dart';
import 'package:delivery_kam/features/main/widgets/order_details_bottom_navbar.dart';
import 'package:delivery_kam/models/address_api.dart';
import 'package:delivery_kam/models/order.dart';
import 'package:flutter/material.dart';

class DeliveryMainOrderDetailsEdit extends StatefulWidget {
  const DeliveryMainOrderDetailsEdit({
    Key? key,
  }) : super(key: key);

  @override
  State<DeliveryMainOrderDetailsEdit> createState() =>
      _DeliveryMainOrderDetailsEditState();
}

class _DeliveryMainOrderDetailsEditState
    extends State<DeliveryMainOrderDetailsEdit> {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final List<AddressPost> addressPostAllList = args['addressPostAllList'];
    final int price = args['price'];
    final Order order = args['order'];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Уточните детали заказа'),
      ),
      bottomNavigationBar: OrderDetailsBottomNavbar(
        order: order,
        price: price,
      ),
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        width: double.infinity,
        child: ListView.builder(
          itemCount: addressPostAllList.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                const Padding(padding: EdgeInsets.only(top: 10)),
                Container(
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
                            addressPostAllList[index].addressRow,
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
                          if (order.toDoor)
                          const SizedBox(
                            width: 20,
                          ),
                          if (order.toDoor)
                          Expanded(
                            child: DeliveryAddressTextfieldCustom(
                              labelText: 'Этаж',
                              controller: TextEditingController(),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          if (order.toDoor)
                          const SizedBox(
                            width: 20,
                          ),
                          if (order.toDoor)
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
                        labelText: 'Имя получателя',
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
