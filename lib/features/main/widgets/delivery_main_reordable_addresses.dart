import 'package:delivery_kam/features/main/bloc/delivery_main_bloc.dart';
import 'package:delivery_kam/features/main/widgets/address_modal_bottom_sheet.dart';
import 'package:delivery_kam/models/address_api.dart';
import 'package:flutter/material.dart';

class DeliveryMainReordableAddresses extends StatefulWidget {
  const DeliveryMainReordableAddresses({
    super.key,
    required this.addressList,
    required this.callback,
    required this.deliveryMainBloc,
  });
  final DeliveryMainBloc deliveryMainBloc;
  final List<AddressApi> addressList;
  final Function(List<AddressApi>) callback;

  @override
  State<DeliveryMainReordableAddresses> createState() =>
      _DeliveryMainReordableAddressesState();
}

class _DeliveryMainReordableAddressesState
    extends State<DeliveryMainReordableAddresses> {
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
            padding: const EdgeInsets.only(top: 15).copyWith(bottom: 50),
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5.0).copyWith(left: 16),
                  child: const Text(
                    'Куда доставим',
                    style: TextStyle(fontSize: 21),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(color: Color(0xff7A7A7A), thickness: 1),
                ),
                ReorderableListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: widget.addressList.asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value;
                    return ListTile(
                      onTap: () {
                        showModalBottomSheet(
                            isScrollControlled: true,
                            elevation: 0,
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (BuildContext context) {
                              return AddressModalBottomSheet(
                                addressFromTextFieldController:
                                    TextEditingController(),
                                deliveryMainBloc: widget.deliveryMainBloc,
                                onAddressReady: (addressApi) {
                                  setState(() {
                                    widget.addressList.removeAt(index);
                                    widget.addressList
                                        .insert(index, addressApi);
                                  });
                                  Navigator.pop(context);
                                },
                                labelText:
                                    '${item.city} ${item.street} ${item.house}',
                                prefixText: '',
                              );
                            });
                      },
                      key: Key(item.fiasId!),
                      title: Text(
                        '${item.street} ${item.house}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontFamily: 'GT-Eesti-Pro-Display',
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      trailing: Wrap(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.remove_circle,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              setState(() {
                                widget.addressList.removeAt(index);
                              });
                            },
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Icon(
                              Icons.menu_outlined,
                              color: Color(0xff7A7A7A),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  onReorder: (oldIndex, newIndex) {
                    setState(() {
                      if (newIndex > oldIndex) {
                        newIndex -= 1;
                      }
                      final AddressApi item =
                          widget.addressList.removeAt(oldIndex);
                      widget.addressList.insert(newIndex, item);
                      // widget.callback(widget.addressList);
                    });
                  },
                ),
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromRGBO(175, 223, 234, 1),
                          Color.fromRGBO(33, 190, 210, 1)
                        ],
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        widget.callback(widget.addressList);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors
                            .transparent, // Чтобы фон ElevatedButton был прозрачным
                        elevation: 0, // Отключаем подъем тени кнопки
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: const Text(
                        'Теперь верно',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
