import 'package:delivery_kam/features/main/bloc/delivery_main_bloc.dart';
import 'package:delivery_kam/features/main/view/delivery_main_map_screen.dart';
import 'package:delivery_kam/features/main/widgets/delivery_main_address_hint.dart';
import 'package:delivery_kam/features/main/widgets/delivery_main_custom_checkbox_list_tile.dart';
import 'package:delivery_kam/features/main/widgets/delivery_main_drawer.dart';
import 'package:delivery_kam/features/main/widgets/delivery_main_textfield_address.dart';
import 'package:delivery_kam/features/main/widgets/delivery_main_textfield_custom.dart';
import 'package:delivery_kam/features/main/widgets/delivery_main_unicorn_outline_button.dart';
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
  final TextEditingController senderNumberTextFieldController =
      TextEditingController();
  final TextEditingController senderNameTextFieldController =
      TextEditingController();
  final TextEditingController recipientNumberTextFieldController =
      TextEditingController();
  final TextEditingController recipientNameTextFieldController =
      TextEditingController();
  final TextEditingController subjectTextFieldController =
      TextEditingController();
  final TextEditingController diamondTextFieldController =
      TextEditingController();
  final TextEditingController weightTextFieldController =
      TextEditingController();
  final TextEditingController envelopeTextFieldController =
      TextEditingController();
  final TextEditingController chatTextFieldController = TextEditingController();

  final double maxChildSize = 0.9;
  final double minChildSize = .425;

  bool _isAuto = false;
  bool _isExpress = false;
  bool _isToDoor = false;
  bool _isFragileCargo = false;
  bool _isThermalBag = false;
  bool _isRegistrationInTransportCompany = false;
  bool _isCorrespondenceInRussianPostOffice = false;
  bool _isShowFromSuggest = false;
  bool _isShowToSuggest = false;
  String _activeTextfield = '';

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
          child: ElevatedButton(
            onPressed: () {
              // Navigator.of(context).pushNamed("/register");
            },
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
          ),
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
              initialChildSize: .425,
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
                              onEditingComplete: () {
                                if (_activeTextfield == 'addressFrom') {
                                  print('exit from');
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
                                              address;
                                          setState(() {
                                            _isShowFromSuggest = false;
                                            _activeTextfield = '';
                                          });
                                          FocusScope.of(context).unfocus();
                                        },
                                        address:
                                            "${state.addresses[index].street} ${state.addresses[index].house ?? ''}",
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
                              onEditingComplete: () {
                                if (_activeTextfield == 'addressTo') {
                                  print('exit to');
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
                                              address;
                                          setState(() {
                                            _isShowToSuggest = false;
                                            _activeTextfield = '';
                                          });
                                          FocusScope.of(context).unfocus();
                                        },
                                        address:
                                            "${state.addresses[index].street} ${state.addresses[index].house ?? ''}",
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
                                        colors: _isAuto
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
                                        setState(() {
                                          _isAuto = false;
                                        });
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
                                        colors: !_isAuto
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
                                        setState(() {
                                          _isAuto = true;
                                        });
                                      },
                                    ),
                                  ),
                                ],
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
                                  'Время доставки',
                                  style: TextStyle(
                                    color: Color.fromRGBO(93, 105, 114, 1),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 10),
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
                                        colors: !_isExpress
                                            ? _activeGradientColor
                                            : _inactiveGradientColor,
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomCenter,
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          children: [
                                            Text(
                                              'Обычная',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              '2-5 часов',
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w300,
                                                color: Color.fromRGBO(
                                                    93, 105, 114, 1),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _isExpress = false;
                                        });
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
                                        colors: _isExpress
                                            ? _activeGradientColor
                                            : _inactiveGradientColor,
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomCenter,
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          children: [
                                            Text(
                                              'Экспресс',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              'Самая быстрая',
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w300,
                                                color: Color.fromRGBO(
                                                    93, 105, 114, 1),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _isExpress = true;
                                        });
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
                              padding: EdgeInsets.only(bottom: 10),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: columnHorizontalPadding),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: UnicornOutlineButton(
                                      height:
                                          MediaQuery.of(context).size.width <=
                                                  350
                                              ? 90
                                              : 60,
                                      strokeWidth: 4,
                                      radius: 16,
                                      gradient: LinearGradient(
                                        colors: !_isToDoor
                                            ? _activeGradientColor
                                            : _inactiveGradientColor,
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomCenter,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                          .size
                                                          .width <=
                                                      350
                                                  ? MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.3
                                                  : MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.35,
                                              child: const Text(
                                                'Выйти к машине',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                          .size
                                                          .width <=
                                                      300
                                                  ? MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.3
                                                  : MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.35,
                                              child: const Text(
                                                'При отправке и получении',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w300,
                                                  color: Color.fromRGBO(
                                                      93, 105, 114, 1),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _isToDoor = false;
                                        });
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
                                      height:
                                          MediaQuery.of(context).size.width <=
                                                  350
                                              ? 90
                                              : 60,
                                      gradient: LinearGradient(
                                        colors: _isToDoor
                                            ? _activeGradientColor
                                            : _inactiveGradientColor,
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomCenter,
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        width: MediaQuery.of(context)
                                                    .size
                                                    .width <=
                                                300
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.3
                                            : MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
                                        child: const Text(
                                          'От двери до двери',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.black,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _isToDoor = true;
                                        });
                                      },
                                    ),
                                  )
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
                              controller: subjectTextFieldController,
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
                              controller: envelopeTextFieldController,
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
                              controller: chatTextFieldController,
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
                                }),
                            DeliveryMainCustomCheckboxListTile(
                                isChecked: _isThermalBag,
                                label: 'Наличие термосумки',
                                onChanged: (bool? newValue) {
                                  setState(() {
                                    _isThermalBag = newValue!;
                                  });
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
}
