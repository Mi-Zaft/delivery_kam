import 'package:delivery_kam/features/main/bloc/delivery_main_bloc.dart';
import 'package:delivery_kam/features/main/view/delivery_main_map_screen.dart';
import 'package:delivery_kam/features/main/widgets/delivery_main_address_hint.dart';
import 'package:delivery_kam/features/main/widgets/delivery_main_custom_checkbox_list_tile.dart';
import 'package:delivery_kam/features/main/widgets/delivery_main_drawer.dart';
import 'package:delivery_kam/features/main/widgets/delivery_main_textfield_address.dart';
import 'package:delivery_kam/features/main/widgets/delivery_main_textfield_custom.dart';
import 'package:delivery_kam/features/main/widgets/delivery_main_unicorn_outline_button.dart';
import 'package:delivery_kam/models/address_api.dart';
import 'package:delivery_kam/models/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class DeliveryMainScreen extends StatefulWidget {
  const DeliveryMainScreen({super.key});

  @override
  State<DeliveryMainScreen> createState() => _DeliveryMainScreenState();
}

class _DeliveryMainScreenState extends State<DeliveryMainScreen> {
  final _deliveryMainBloc = DeliveryMainBloc();
  final _activeGradientColor = [
    const Color.fromRGBO(175, 223, 233, 1),
    const Color.fromRGBO(32, 191, 208, 1)
  ];
  final _inactiveGradientColor = [
    const Color.fromRGBO(195, 195, 195, 1),
    const Color.fromRGBO(195, 195, 195, 1)
  ];
  final double columnHorizontalPadding = 24.0; // Отступы по бокам
  final TextEditingController addressFromTextFieldController =
      TextEditingController();
  final TextEditingController addressToTextFieldController =
      TextEditingController();
  final TextEditingController floorFlatOrOfficeSenderController = TextEditingController();
  final TextEditingController floorFlatOrOfficeRecipientController =
      TextEditingController();
  final TextEditingController senderNumberTextFieldController =
      TextEditingController();
  final TextEditingController senderNameTextFieldController =
      TextEditingController();
  final TextEditingController recipientNumberTextFieldController =
      TextEditingController();
  final TextEditingController recipientNameTextFieldController =
      TextEditingController();
  final TextEditingController cargoItemTextFieldController =
      TextEditingController();
  final TextEditingController commentTextFieldController =
      TextEditingController();
  final TextEditingController messageToRecipientTextFieldController = TextEditingController();

  final double maxChildSize = 0.9;
  final double minChildSize = .39;

  String fromWhere = '';
  AddressApi fromWhereObject = AddressApi(street: '');
  AddressApi toWhereObjext = AddressApi(street: '');
  String toWhere = '';
  bool _byCar = false;
  bool _isFragileCargo = false;
  bool _isThermalBag = false;
  bool _isBulkyCargo = false;
  bool _isRegistrationInTransportCompany = false;
  bool _isCorrespondenceInRussianPostOffice = false;
  bool _isShowFromSuggest = false;
  bool _isShowToSuggest = false;
  String _activeTextfield = '';
  Order? order;

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
      key: _scaffoldKey,
      drawer: const DeliveryMainDrawer(),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding:
            const EdgeInsets.only(bottom: 25.0, top: 10, left: 16, right: 16),
        child: SizedBox(
          width: double.infinity,
          child: BlocBuilder<DeliveryMainBloc, DeliveryMainState>(
              bloc: _deliveryMainBloc,
              builder: (context, state) {
                if (state is DeliveryMainLoading) {
                  return ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: const Color.fromRGBO(195, 195, 195, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: const SizedBox(
                      height: 25,
                      width: 25,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Color.fromRGBO(32, 191, 208, 1),
                        ),
                      ),
                    ),
                  );
                } else if (state is DeliveryMainOrderPriceSuccess) {
                  return Container(
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
                        makeOrder();
                        if (order != null) {
                          _deliveryMainBloc.add(OrderCreateLoading(order!));
                        }
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
                      child: Text(
                        'Заказать за ${state.price}₽',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  );
                } else {
                  return ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: const Color.fromRGBO(195, 195, 195, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: const Text(
                      "Укажите адрес",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                  );
                }
              }),
        ),
      ),
      body: Stack(children: [
        DeliveryMainMapScreen(openDrawer: openDrawer),
        SizedBox.expand(
          child: NotificationListener<DraggableScrollableNotification>(
            onNotification: (notification) {
              return true;
            },
            child: DraggableScrollableSheet(
              initialChildSize: minChildSize,
              minChildSize: minChildSize,
              maxChildSize: maxChildSize,
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
                            const Padding(
                              padding: EdgeInsets.only(top: 20),
                            ),
                            DeliveryMainTextfieldAddress(
                              onTap: () {
                                _activeTextfield = 'addressFrom';
                                setState(() {
                                  _isShowToSuggest = false;
                                });
                              },
                              onEditingComplete: () {
                                if (_activeTextfield == 'addressFrom') {
                                  print('exit from');
                                  setState(() {
                                    _isShowFromSuggest = false;
                                    _activeTextfield = '';
                                  });
                                  FocusScope.of(context).unfocus();
                                }
                              },
                              onChange: () {
                                _activeTextfield = 'addressFrom';
                                setState(() {
                                  _isShowToSuggest = false;
                                });
                                if (addressFromTextFieldController
                                        .text.length >=
                                    3) {
                                  _isShowFromSuggest = true;
                                  _deliveryMainBloc.add(
                                    LoadingMainAddressHintRequest(
                                      addressFromTextFieldController.text,
                                    ),
                                  );
                                } else {
                                  setState(() {
                                    _isShowFromSuggest = false;
                                  });
                                }
                              },
                              labelText: 'Откуда забрать',
                              prefixStyle: const TextStyle(
                                fontSize: 20,
                                color: Color.fromRGBO(122, 122, 122, 1),
                              ),
                              controller: addressFromTextFieldController,
                              keyboardType: TextInputType.streetAddress,
                              prefixText: "А",
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            BlocBuilder<DeliveryMainBloc, DeliveryMainState>(
                              bloc: _deliveryMainBloc,
                              builder: (context, state) {
                                if (state is DeliveryMainAddressHintSuccess &&
                                    _isShowFromSuggest) {
                                  return ListView.builder(
                                    padding: const EdgeInsets.all(0),
                                    itemCount: state.addresses.length,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder:
                                        (BuildContext listContext, int index) {
                                      return DeliveryMainAddressHint(
                                        onClick: (address) {
                                          addressFromTextFieldController.text =
                                              "${address.street} ${address.house ?? ''}";
                                          fromWhere =
                                              "${address.street} ${address.house ?? ''}";
                                          fromWhereObject = address;
                                          if (address.fiasLevel != null) {
                                            if (address.fiasLevel! >= 8) {
                                              setState(() {
                                                _isShowFromSuggest = false;
                                                _activeTextfield = '';
                                              });
                                              FocusScope.of(context).unfocus();
                                              if (fromWhereObject.fiasId !=
                                                      null &&
                                                  toWhereObjext.fiasId !=
                                                      null) {
                                                order = Order(
                                                    fromFiasId:
                                                        fromWhereObject.fiasId!,
                                                    whereFiasId:
                                                        toWhereObjext.fiasId!,
                                                    byCar: _byCar);
                                                makeOrder();
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
                            ),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 10),
                            ),
                            DeliveryMainTextfieldAddress(
                              onTap: () {
                                _activeTextfield = 'addressTo';
                                setState(() {
                                  _isShowFromSuggest = false;
                                });
                              },
                              onEditingComplete: () {
                                if (_activeTextfield == 'addressTo') {
                                  print('exit to');
                                  setState(() {
                                    _isShowToSuggest = false;
                                    _activeTextfield = '';
                                  });
                                  FocusScope.of(context).unfocus();
                                }
                              },
                              onChange: () {
                                _activeTextfield = 'addressTo';
                                setState(() {
                                  _isShowFromSuggest = false;
                                });
                                if (addressToTextFieldController.text.length >=
                                    3) {
                                  _isShowToSuggest = true;
                                  _deliveryMainBloc.add(
                                    LoadingMainAddressHintRequest(
                                      addressToTextFieldController.text,
                                    ),
                                  );
                                } else {
                                  setState(() {
                                    _isShowToSuggest = false;
                                  });
                                }
                              },
                              labelText: 'Куда доставить',
                              prefixStyle: const TextStyle(
                                fontSize: 20,
                                color: Color.fromRGBO(122, 122, 122, 1),
                              ),
                              controller: addressToTextFieldController,
                              keyboardType: TextInputType.streetAddress,
                              prefixText: "Б",
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            BlocBuilder<DeliveryMainBloc, DeliveryMainState>(
                              bloc: _deliveryMainBloc,
                              builder: (context, state) {
                                if (state is DeliveryMainAddressHintSuccess &&
                                    _isShowToSuggest) {
                                  return ListView.builder(
                                    padding: const EdgeInsets.all(0),
                                    itemCount: state.addresses.length,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder:
                                        (BuildContext listContext, int index) {
                                      return DeliveryMainAddressHint(
                                        onClick: (address) {
                                          addressToTextFieldController.text =
                                              "${address.street} ${address.house ?? ''}";
                                          toWhere =
                                              "${address.street} ${address.house ?? ''}";
                                          toWhereObjext = address;
                                          if (address.fiasLevel != null) {
                                            if (address.fiasLevel! >= 8) {
                                              setState(() {
                                                _isShowToSuggest = false;
                                                _activeTextfield = '';
                                              });
                                              FocusScope.of(context).unfocus();
                                              if (fromWhereObject.fiasId !=
                                                      null &&
                                                  toWhereObjext.fiasId !=
                                                      null) {
                                                order = Order(
                                                    fromFiasId:
                                                        fromWhereObject.fiasId!,
                                                    whereFiasId:
                                                        toWhereObjext.fiasId!,
                                                    byCar: _byCar);
                                                makeOrder();
                                              }
                                            }
                                          }
                                        },
                                        address: state.addresses[index],
                                        // "${state.addresses[index].street} ${state.addresses[index].house ?? ''}",
                                      );
                                    },
                                  );
                                } else {
                                  return const SizedBox.shrink();
                                }
                              },
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 25),
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
                                                "assets/images/main/iconcar.png"),
                                          ],
                                        ),
                                      ),
                                      onPressed: () {
                                        order?.byCar = true;
                                        setState(() {
                                          _byCar = true;
                                        });
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
                                  'Уточнение адреса',
                                  style: TextStyle(
                                    color: Color.fromRGBO(93, 105, 114, 1),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: DeliveryMainTextfieldCustom(
                                labelText: 'Этаж, квартира/офис отправителя',
                                controller: floorFlatOrOfficeSenderController,
                                prefixStyle: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black,
                                ),
                                keyboardType: TextInputType.streetAddress,
                                prefixText: "А",
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: DeliveryMainTextfieldCustom(
                                labelText: 'Этаж, квартира/офис получателя',
                                controller: floorFlatOrOfficeRecipientController,
                                prefixStyle: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black,
                                ),
                                keyboardType: TextInputType.streetAddress,
                                prefixText: "Б",
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
                                  'Введите номер телефона отправителя',
                                  style: TextStyle(
                                    color: Color.fromRGBO(93, 105, 114, 1),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            ),
                            DeliveryMainTextfieldCustom(
                              labelText: '',
                              controller: senderNumberTextFieldController,
                              maskInputFormatters: [phoneMaskFormatter],
                              prefixStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                                color: Colors.black,
                              ),
                              keyboardType: TextInputType.phone,
                              prefixText: "+7",
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 20),
                            ),
                            DeliveryMainTextfieldCustom(
                                labelText: 'Введите имя отправителя',
                                controller: senderNameTextFieldController,
                                keyboardType: TextInputType.name),
                            const Padding(
                              padding: EdgeInsets.only(top: 20),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: columnHorizontalPadding),
                              child: const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Введите номер телефона получателя',
                                  style: TextStyle(
                                    color: Color.fromRGBO(93, 105, 114, 1),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            ),
                            DeliveryMainTextfieldCustom(
                              labelText: '',
                              controller: recipientNumberTextFieldController,
                              maskInputFormatters: [phoneMaskFormatter],
                              prefixStyle: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black),
                              keyboardType: TextInputType.phone,
                              prefixText: "+7",
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 20),
                            ),
                            DeliveryMainTextfieldCustom(
                                labelText: 'Введите имя получателя',
                                controller: recipientNameTextFieldController,
                                keyboardType: TextInputType.name),
                            const Padding(
                              padding: EdgeInsets.only(top: 25),
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
                            DeliveryMainTextfieldCustom(
                              labelText: 'Сообщение получателю',
                              controller: messageToRecipientTextFieldController,
                              prefixStyle: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black),
                              keyboardType: TextInputType.text,
                              prefixIcon: Image.asset(
                                "assets/images/main/iconChat.png",
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
                                  makeOrder();
                                }),
                            DeliveryMainCustomCheckboxListTile(
                                isChecked: _isThermalBag,
                                label: 'Наличие термосумки',
                                onChanged: (bool? newValue) {
                                  setState(() {
                                    _isThermalBag = newValue!;
                                  });
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

  void makeOrder() {
    if (order != null) {
      order!.byCar = _byCar;
      order!.floorFlatOrOfficeSender = floorFlatOrOfficeSenderController.text;
      order!.floorFlatOrOfficeRecipient = floorFlatOrOfficeRecipientController.text;
      order!.senderPhone = '+7${phoneMaskFormatter.unmaskText(senderNumberTextFieldController.text)}';
      order!.senderName = senderNameTextFieldController.text;
      order!.recipientPhone = '+7${phoneMaskFormatter.unmaskText(recipientNumberTextFieldController.text)}';
      order!.recipientName = recipientNameTextFieldController.text;
      order!.cargoItem = cargoItemTextFieldController.text;
      order!.comment = commentTextFieldController.text;
      order!.messageToRecipient = messageToRecipientTextFieldController.text;
      order!.fragileCargo = _isFragileCargo;
      order!.thermalBag = _isThermalBag;
      order!.bulkyCargo = _isBulkyCargo;
      order!.transportDepartureRegistration = _isRegistrationInTransportCompany;
      order!.postOfficeCorrespondence = _isCorrespondenceInRussianPostOffice;
    } else {
      if (fromWhereObject.fiasId != null && toWhereObjext.fiasId != null) {
        order = Order(
          fromFiasId: fromWhereObject.fiasId!,
          whereFiasId: toWhereObjext.fiasId!,
          byCar: _byCar,
          fragileCargo: _isFragileCargo,
          thermalBag: _isThermalBag,
          bulkyCargo: _isBulkyCargo,
          transportDepartureRegistration: _isRegistrationInTransportCompany,
          postOfficeCorrespondence: _isCorrespondenceInRussianPostOffice,
        );
      }
    }
    if (order != null) {
      _deliveryMainBloc.add(OrderDataChanged(order!));
    }
  }
}
