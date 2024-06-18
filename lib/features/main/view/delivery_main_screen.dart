import 'package:delivery_kam/features/main/bloc/delivery_main_bloc.dart';
import 'package:delivery_kam/features/main/view/delivery_main_map_screen.dart';
import 'package:delivery_kam/features/main/widgets/address_modal_bottom_sheet.dart';
import 'package:delivery_kam/features/main/widgets/delivery_main_address_to_tapped_row.dart';
import 'package:delivery_kam/features/main/widgets/delivery_main_address_from_tapped_row.dart';
import 'package:delivery_kam/features/main/widgets/delivery_main_bottom_navbar.dart';
import 'package:delivery_kam/features/main/widgets/delivery_main_custom_checkbox_list_tile.dart';
import 'package:delivery_kam/features/main/widgets/delivery_main_drawer.dart';
import 'package:delivery_kam/features/main/widgets/delivery_main_textfield_custom.dart';
import 'package:delivery_kam/features/main/widgets/delivery_main_unicorn_outline_button.dart';
import 'package:delivery_kam/models/address_api.dart';
import 'package:delivery_kam/models/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class DeliveryMainScreen extends StatefulWidget {
  const DeliveryMainScreen({super.key});

  @override
  State<DeliveryMainScreen> createState() => _DeliveryMainScreenState();
}

class _DeliveryMainScreenState extends State<DeliveryMainScreen> {
  final deliveryMainBloc = DeliveryMainBloc();
  final _activeGradientColor = [
    const Color.fromRGBO(175, 223, 233, 1),
    const Color.fromRGBO(32, 191, 208, 1)
  ];
  final _inactiveGradientColor = [
    const Color.fromRGBO(195, 195, 195, 1),
    const Color.fromRGBO(195, 195, 195, 1)
  ];
  final double columnHorizontalPadding = 24.0; // Отступы по бокам

  final TextEditingController addressToTextFieldController =
      TextEditingController();
  final TextEditingController cargoItemTextFieldController =
      TextEditingController();
  final TextEditingController commentTextFieldController =
      TextEditingController();
  final MapController mapController = MapController();

  final double maxChildSize = 0.9;
  final double minChildSize = .39;
  final List<Marker> markers = [];

  AddressApi fromWhereObject = AddressApi(street: '', city: '');
  AddressApi toWhereObjext = AddressApi(street: '', city: '');
  String toWhere = '';
  bool _byCar = false;
  bool _toDoor = false;
  bool _isFragileCargo = false;
  bool _isThermalBag = false;
  bool _isBulkyCargo = false;
  bool _isRegistrationInTransportCompany = false;
  bool _isCorrespondenceInRussianPostOffice = false;
  final DraggableScrollableController _draggableBottomSheetController =
      DraggableScrollableController();

  Order? order;
  Order? mainOrder;
  AddressPost? addressPostFrom;
  AddressApi? addressApiFrom;
  List<AddressPost> addressPostToList = [];
  List<AddressApi> addressApiToList = [];
  List<AddressPost> addressPostAllList = [];

  void openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  var phoneMaskFormatter = MaskTextInputFormatter(
      mask: '(###) ###-##-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      drawer: const DeliveryMainDrawer(),
      bottomNavigationBar: DeliveryMainBottomNavbar(
        addressPostAllList: addressPostAllList,
        deliveryMainBloc: deliveryMainBloc,
        makeOrder: makeOrder,
        order: mainOrder,
      ),
      body: Stack(children: [
        DeliveryMainMapScreen(
          openDrawer: openDrawer,
          markers: markers,
          mapController: mapController,
        ),
        SizedBox.expand(
          child: NotificationListener<DraggableScrollableNotification>(
            onNotification: (notification) {
              FocusScope.of(context).unfocus();
              return true;
            },
            child: DraggableScrollableSheet(
              controller: _draggableBottomSheetController,
              initialChildSize: minChildSize,
              minChildSize: minChildSize,
              maxChildSize: maxChildSize,
              snap: true,
              snapSizes: [minChildSize, maxChildSize],
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                          spreadRadius: 5,
                          blurRadius: 5,
                        )
                      ]),
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    controller: scrollController,
                    child: GestureDetector(
                      onTap: () =>
                          {FocusScope.of(context).requestFocus(FocusNode())},
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                          ),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              width: 50,
                              child: Divider(
                                thickness: 5,
                              ),
                            ),
                            DeliveryMainAddressFromTappedRow(
                              labelText: addressPostFrom != null
                                  ? addressPostFrom!.addressRow
                                  : 'Откуда забрать',
                              prefixText: 'А',
                              onAddressReady: (addressFromRow) {
                                addressApiFrom = addressFromRow;
                                setState(() {
                                  addressPostFrom = AddressPost(
                                      fiasId: addressFromRow.fiasId!,
                                      priority: 0,
                                      addressRow:
                                          '${addressFromRow.street} ${addressFromRow.house}');
                                });
                                makeOrder();
                                if (addressApiFrom!.latitude != null &&
                                    addressApiFrom!.longitude != null) {
                                  updateMap(LatLng(addressApiFrom!.latitude!,
                                      addressApiFrom!.longitude!));
                                }
                              },
                            ),
                            DeliveryMainAddressToTappedRow(
                              addressList: addressApiToList,
                              labelText: getRowWhere(),
                              prefixText: 'Б',
                              onAddressReady: (List<AddressApi> addressList) {
                                addressApiToList = addressList;
                                setState(() {
                                  addressPostToList.clear();
                                  for (var i = 0; i < addressList.length; i++) {
                                    addressPostToList.add(
                                      AddressPost(
                                        fiasId: addressList[i].fiasId!,
                                        priority: i + 1,
                                        addressRow:
                                            '${addressList[i].street} ${addressList[i].house}',
                                      ),
                                    );
                                  }
                                });
                                makeOrder();
                                if (addressList.last.latitude != null &&
                                    addressList.last.longitude != null) {
                                  updateMap(LatLng(addressList.last.latitude!,
                                      addressList.last.longitude!));
                                }
                              },
                              callBack:
                                  (List<AddressApi> reorderedAddressToList) {
                                addressApiToList = reorderedAddressToList;
                                addressPostToList.clear();
                                for (var i = 0;
                                    i < addressApiToList.length;
                                    i++) {
                                  addressPostToList.add(AddressPost(
                                      fiasId: addressApiToList[i].fiasId!,
                                      priority: i + 1,
                                      addressRow:
                                          '${addressApiToList[i].street} ${addressApiToList[i].house}'));
                                }
                                makeOrder();
                              },
                            ),
                            if (addressPostToList.isNotEmpty &&
                                addressPostToList.length < 5)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: GestureDetector(
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
                                              deliveryMainBloc:
                                                  deliveryMainBloc,
                                              onAddressReady:
                                                  (AddressApi address) {
                                                setState(() {
                                                  addressApiToList.add(address);
                                                  addressPostToList.add(
                                                    AddressPost(
                                                        fiasId: address.fiasId!,
                                                        priority:
                                                            addressPostToList
                                                                    .length +
                                                                1,
                                                        addressRow:
                                                            '${address.street} ${address.house}'),
                                                  );
                                                });
                                                makeOrder();
                                                if (address.latitude != null &&
                                                    address.longitude != null) {
                                                  updateMap(LatLng(
                                                      address.latitude!,
                                                      address.longitude!));
                                                }
                                                Navigator.pop(context);
                                              },
                                              labelText: 'Дополнительный адрес',
                                              prefixText: '',
                                            );
                                          });
                                    },
                                    child: Icon(
                                      Icons.add_outlined,
                                      color: _activeGradientColor[1],
                                    )),
                              ),
                            // IconButton(
                            //     onPressed: () {
                            //       List<String> items = List.generate(
                            //           5, (index) => "Item ${index + 1}");
                            //       showModalBottomSheet(
                            //           // isScrollControlled: true,
                            //           elevation: 0,
                            //           backgroundColor: Colors.white,
                            //           context: context,
                            //           builder: (BuildContext context) {
                            //             return ReorderableListView(
                            //               physics:
                            //                   const NeverScrollableScrollPhysics(),
                            //               children: items
                            //                   .map((item) => ListTile(
                            //                         key: Key(item),
                            //                         title: Text(item),
                            //                       ))
                            //                   .toList(),
                            //               onReorder: (oldIndex, newIndex) {
                            //                 setState(() {
                            //                   if (newIndex > oldIndex) {
                            //                     newIndex -= 1;
                            //                   }
                            //                   final String item =
                            //                       items.removeAt(oldIndex);
                            //                   items.insert(newIndex, item);
                            //                 });
                            //               },
                            //             );
                            //           });
                            //     },
                            //     icon: Icon(Icons.abc_outlined)),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                      horizontal: columnHorizontalPadding)
                                  .copyWith(top: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: UnicornOutlineButton(
                                      strokeWidth: 4,
                                      radius: 16,
                                      gradient: LinearGradient(
                                        colors: _byCar
                                            ? _inactiveGradientColor
                                            : _activeGradientColor,
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomCenter,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          children: [
                                            const Text('Пеший курьер'),
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 10),
                                            ),
                                            Image.asset(
                                                "assets/images/main/iconcourier.png"),
                                          ],
                                        ),
                                      ),
                                      onPressed: () {
                                        order?.byCar = false;
                                        setState(() {
                                          _byCar = false;
                                          if (_isBulkyCargo == true) {
                                            _isBulkyCargo = false;
                                          }
                                        });
                                        FocusScope.of(context).unfocus();
                                        makeOrder();
                                      },
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(right: 15),
                                  ),
                                  Expanded(
                                    child: UnicornOutlineButton(
                                      strokeWidth: 4,
                                      radius: 16,
                                      gradient: LinearGradient(
                                        colors: !_byCar
                                            ? _inactiveGradientColor
                                            : _activeGradientColor,
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomCenter,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          children: [
                                            const Text('Курьер на авто'),
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 10),
                                            ),
                                            Image.asset(
                                                "assets/images/main/iconCar.png"),
                                          ],
                                        ),
                                      ),
                                      onPressed: () {
                                        order?.byCar = true;
                                        setState(() {
                                          _byCar = true;
                                        });
                                        FocusScope.of(context).unfocus();
                                        makeOrder();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 20),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: columnHorizontalPadding),
                              child: const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Как доставить',
                                  style: TextStyle(
                                    color: Color.fromRGBO(93, 105, 114, 1),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 10),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: columnHorizontalPadding),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: UnicornOutlineButton(
                                      strokeWidth: 4,
                                      radius: 16,
                                      gradient: LinearGradient(
                                        colors: _toDoor
                                            ? _inactiveGradientColor
                                            : _activeGradientColor,
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomCenter,
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          children: [
                                            Text('Выйти к машине'),
                                            Text(
                                              'При отправке и получении',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w100),
                                            )
                                          ],
                                        ),
                                      ),
                                      onPressed: () {
                                        order?.toDoor = false;
                                        setState(() {
                                          _toDoor = false;
                                        });
                                        FocusScope.of(context).unfocus();
                                        makeOrder();
                                      },
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(right: 15),
                                  ),
                                  Expanded(
                                    child: UnicornOutlineButton(
                                      strokeWidth: 4,
                                      radius: 16,
                                      gradient: LinearGradient(
                                        colors: !_toDoor
                                            ? _inactiveGradientColor
                                            : _activeGradientColor,
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomCenter,
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(10),
                                        child: SizedBox(
                                          height: 35,
                                          child: Center(
                                            child: Text('От двери до двери',
                                                textAlign: TextAlign.center),
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        order?.toDoor = true;
                                        setState(() {
                                          _toDoor = true;
                                        });
                                        FocusScope.of(context).unfocus();
                                        makeOrder();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 20),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: columnHorizontalPadding),
                              child: const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Детали отправки',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                            ),
                            DeliveryMainTextfieldCustom(
                              labelText: 'Предмет доставки',
                              controller: cargoItemTextFieldController,
                              prefixStyle: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black),
                              keyboardType: TextInputType.text,
                              prefixIcon: Image.asset(
                                "assets/images/main/iconbox.png",
                              ),
                            ),
                            DeliveryMainTextfieldCustom(
                              labelText: 'Комментарий курьеру',
                              controller: commentTextFieldController,
                              prefixStyle: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black),
                              keyboardType: TextInputType.text,
                              prefixIcon: Image.asset(
                                "assets/images/main/iconEnvelope.png",
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 25),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: columnHorizontalPadding),
                              child: const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Дополнительно',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                            ),
                            DeliveryMainCustomCheckboxListTile(
                                isChecked: _isFragileCargo,
                                label: 'Хрупкий груз',
                                onChanged: (bool? newValue) {
                                  setState(() {
                                    _isFragileCargo = newValue!;
                                  });
                                  FocusScope.of(context).unfocus();
                                  makeOrder();
                                }),
                            DeliveryMainCustomCheckboxListTile(
                                isChecked: _isThermalBag,
                                label: 'Наличие термосумки',
                                onChanged: (bool? newValue) {
                                  setState(() {
                                    _isThermalBag = newValue!;
                                  });
                                  FocusScope.of(context).unfocus();
                                  makeOrder();
                                }),
                            DeliveryMainCustomCheckboxListTile(
                                isChecked: _isBulkyCargo,
                                label: 'Крупногабаритный груз 120 - 210 см',
                                onChanged: (bool? newValue) {
                                  setState(() {
                                    _isBulkyCargo = newValue!;
                                    if (_isBulkyCargo == true &&
                                        _byCar == false) {
                                      _byCar = true;
                                    }
                                  });
                                  FocusScope.of(context).unfocus();
                                  makeOrder();
                                }),
                            DeliveryMainCustomCheckboxListTile(
                                isChecked: _isRegistrationInTransportCompany,
                                label:
                                    'Оформление отправления в транспортной компании',
                                onChanged: (bool? newValue) {
                                  setState(() {
                                    _isRegistrationInTransportCompany =
                                        newValue!;
                                  });
                                  FocusScope.of(context).unfocus();
                                  makeOrder();
                                }),
                            DeliveryMainCustomCheckboxListTile(
                                isChecked: _isCorrespondenceInRussianPostOffice,
                                label:
                                    'Отправка/получение корреспонденции в отделениях Почты России',
                                onChanged: (bool? newValue) {
                                  setState(() {
                                    _isCorrespondenceInRussianPostOffice =
                                        newValue!;
                                  });
                                  FocusScope.of(context).unfocus();
                                  makeOrder();
                                }),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ]),
    );
  }

  String getRowWhere() {
    if (addressPostToList.length == 1) {
      return addressPostToList[0].addressRow;
    } else if (addressPostToList.length > 1 && addressPostToList.length < 5) {
      return 'Выбрано ${addressPostToList.length} адреса';
    } else if (addressPostToList.length == 5) {
      return 'Выбрано 5 адресов';
    } else {
      return 'Куда доставить';
    }
  }

  void updateMap(LatLng pointToMove) {
    markers.clear();
    if (addressApiFrom != null) {
      markers.add(
        Marker(
          point: LatLng(addressApiFrom!.latitude!, addressApiFrom!.longitude!),
          width: 60,
          height: 60,
          child: const Icon(
            Icons.location_on,
            color: Color.fromRGBO(32, 191, 208, 1),
            size: 45,
          ),
        ),
      );
    }

    if (addressApiToList.isNotEmpty) {
      for (var i = 0; i < addressApiToList.length; i++) {
        markers.add(
          Marker(
            point: LatLng(
                addressApiToList[i].latitude!, addressApiToList[i].longitude!),
            width: 60,
            height: 60,
            child: const Icon(
              Icons.location_on,
              color: Colors.red,
              size: 45,
            ),
          ),
        );
      }
      List<LatLng> points = [];

      for (var i = 0; i < markers.length; i++) {
        points.add(markers[i].point);
      }
    }
    mapController.move(pointToMove, 17);
  }

  void makeOrder() {
    if (addressPostFrom != null && addressPostToList.isNotEmpty) {
      final List<AddressPost> finalAddressList = [];
      finalAddressList.insert(0, addressPostFrom!);
      for (var i = 0; i < addressPostToList.length; i++) {
        addressPostToList[i].priority = i + 1;
        finalAddressList.add(addressPostToList[i]);
        addressPostAllList = finalAddressList;
      }
      if (order != null) {
        order!.address = finalAddressList;
        order!.byCar = _byCar;
        order!.toDoor = _toDoor;
        order!.cargoItem = cargoItemTextFieldController.text;
        order!.comment = commentTextFieldController.text;
        order!.fragileCargo = _isFragileCargo;
        order!.thermalBag = _isThermalBag;
        order!.bulkyCargo = _isBulkyCargo;
        order!.transportDepartureRegistration =
            _isRegistrationInTransportCompany;
        order!.postOfficeCorrespondence = _isCorrespondenceInRussianPostOffice;
      } else {
        order = Order(
          address: finalAddressList,
          byCar: _byCar,
          toDoor: _toDoor,
          fragileCargo: _isFragileCargo,
          thermalBag: _isThermalBag,
          bulkyCargo: _isBulkyCargo,
          transportDepartureRegistration: _isRegistrationInTransportCompany,
          postOfficeCorrespondence: _isCorrespondenceInRussianPostOffice,
        );
      }
      setState(() {
        mainOrder = order;
      });
      if (order != null) {
        deliveryMainBloc.add(OrderDataChanged(order!));
      }
    }
  }
}
