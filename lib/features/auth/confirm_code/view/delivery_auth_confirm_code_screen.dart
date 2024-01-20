import 'package:delivery_kam/features/auth/confirm_code/bloc/delivery_auth_confirm_code_bloc.dart';
import 'package:delivery_kam/features/auth/confirm_code/widgets/delivery_auth_confirm_code_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class DeliveryAuthConfirmCodeScreen extends StatefulWidget {
  const DeliveryAuthConfirmCodeScreen({Key? key}) : super(key: key);

  @override
  State<DeliveryAuthConfirmCodeScreen> createState() =>
      _DeliveryAuthConfirmCodeScreenState();
}

class _DeliveryAuthConfirmCodeScreenState
    extends State<DeliveryAuthConfirmCodeScreen> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final _deliveryAuthConfirmCodeBloc = DeliveryAuthConfirmCodeBloc();
  final double buttonHeight = 15; // Высота кнопок
  final double columnHorizontalPadding =
      24.0; // Отступы по бокам столбца кнопок
  final TextEditingController _firstTextFieldController =
      TextEditingController();
  final TextEditingController _secondTextFieldController =
      TextEditingController();
  final TextEditingController _thirdTextFieldController =
      TextEditingController();
  final TextEditingController _fourTextFieldController =
      TextEditingController();
  final TextEditingController _fiveTextFieldController =
      TextEditingController();
  final TextEditingController _sixTextFieldController = TextEditingController();
  bool isError = false;

  late List<TextEditingController> textControllers;
  late List<FocusNode> focusNodes;

  @override
  void initState() {
    super.initState();

    textControllers = [
      _firstTextFieldController,
      _secondTextFieldController,
      _thirdTextFieldController,
      _fourTextFieldController,
      _fiveTextFieldController,
      _sixTextFieldController
    ];

    focusNodes = List.generate(textControllers.length, (index) => FocusNode());
  }

  @override
  void dispose() {
    _firstTextFieldController.dispose();
    _secondTextFieldController.dispose();
    _thirdTextFieldController.dispose();
    _fourTextFieldController.dispose();
    _fiveTextFieldController.dispose();
    _sixTextFieldController.dispose();

    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _requestFocus(int index) {
    if (index < focusNodes.length - 1) {
      FocusScope.of(context).requestFocus(focusNodes[index + 1]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String phoneNumber = args['phoneNumber'];
    final String userName = args['userName'];
    final String unMaskedPhoneNumber = args['unMaskedPhoneNumber'];
    return BlocProvider(
        create: (BuildContext context) => DeliveryAuthConfirmCodeBloc(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Регистрация"),
            iconTheme:
                const IconThemeData(color: Color.fromRGBO(149, 149, 149, 1)),
          ),
          body: BlocListener<DeliveryAuthConfirmCodeBloc,
              DeliveryAuthConfirmCodeState>(
            bloc: _deliveryAuthConfirmCodeBloc,
            listener: (context, state) {
              if (state is DeliveryAuthConfirmCodeSuccess) {
                Navigator.pushNamed(context, '/main-screen', arguments: {});
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 25, top: 15),
                    child: Text(
                      "Введите полученный код",
                      style: TextStyle(
                        color: Color.fromRGBO(122, 122, 122, 1),
                        fontFamily: "GT-Eesti-Pro-Display",
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 25, top: 15, bottom: 10),
                    child: Text(
                      phoneNumber,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Color.fromRGBO(122, 122, 122, 1),
                        fontFamily: "GT-Eesti-Pro-Display",
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BlocProvider.value(
                          value: _deliveryAuthConfirmCodeBloc,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const SizedBox(width: 24),
                              Expanded(
                                  child: DeliveryAuthConfirmCodeTextfield(
                                      controller: textControllers[0],
                                      focusNode: focusNodes[0],
                                      isError: isError,
                                      onChanged: (value) {
                                        if (value!.isNotEmpty) {
                                          focusNodes[1].requestFocus();
                                          _deliveryAuthConfirmCodeBloc.add(
                                              EditingCode(textControllers[0]
                                                      .value
                                                      .text +
                                                  textControllers[1]
                                                      .value
                                                      .text +
                                                  textControllers[2]
                                                      .value
                                                      .text +
                                                  textControllers[3]
                                                      .value
                                                      .text +
                                                  textControllers[4]
                                                      .value
                                                      .text +
                                                  textControllers[5]
                                                      .value
                                                      .text));
                                        }
                                      })),
                              const SizedBox(width: 5),
                              Expanded(
                                  child: DeliveryAuthConfirmCodeTextfield(
                                      controller: textControllers[1],
                                      focusNode: focusNodes[1],
                                      isError: isError,
                                      onChanged: (value) {
                                        if (value!.isNotEmpty) {
                                          focusNodes[2].requestFocus();
                                          _deliveryAuthConfirmCodeBloc.add(
                                              EditingCode(textControllers[0]
                                                      .value
                                                      .text +
                                                  textControllers[1]
                                                      .value
                                                      .text +
                                                  textControllers[2]
                                                      .value
                                                      .text +
                                                  textControllers[3]
                                                      .value
                                                      .text +
                                                  textControllers[4]
                                                      .value
                                                      .text +
                                                  textControllers[5]
                                                      .value
                                                      .text));
                                        }
                                      })),
                              const SizedBox(width: 5),
                              Expanded(
                                  child: DeliveryAuthConfirmCodeTextfield(
                                      controller: textControllers[2],
                                      focusNode: focusNodes[2],
                                      isError: isError,
                                      onChanged: (value) {
                                        if (value!.isNotEmpty) {
                                          focusNodes[3].requestFocus();
                                          _deliveryAuthConfirmCodeBloc.add(
                                              EditingCode(textControllers[0]
                                                      .value
                                                      .text +
                                                  textControllers[1]
                                                      .value
                                                      .text +
                                                  textControllers[2]
                                                      .value
                                                      .text +
                                                  textControllers[3]
                                                      .value
                                                      .text +
                                                  textControllers[4]
                                                      .value
                                                      .text +
                                                  textControllers[5]
                                                      .value
                                                      .text));
                                        }
                                      })),
                              const SizedBox(width: 5),
                              Expanded(
                                  child: DeliveryAuthConfirmCodeTextfield(
                                      controller: textControllers[3],
                                      focusNode: focusNodes[3],
                                      isError: isError,
                                      onChanged: (value) {
                                        if (value!.isNotEmpty) {
                                          focusNodes[4].requestFocus();
                                          _deliveryAuthConfirmCodeBloc.add(
                                              EditingCode(textControllers[0]
                                                      .value
                                                      .text +
                                                  textControllers[1]
                                                      .value
                                                      .text +
                                                  textControllers[2]
                                                      .value
                                                      .text +
                                                  textControllers[3]
                                                      .value
                                                      .text +
                                                  textControllers[4]
                                                      .value
                                                      .text +
                                                  textControllers[5]
                                                      .value
                                                      .text));
                                        }
                                      })),
                              const SizedBox(width: 5),
                              Expanded(
                                  child: DeliveryAuthConfirmCodeTextfield(
                                      controller: textControllers[4],
                                      focusNode: focusNodes[4],
                                      isError: isError,
                                      onChanged: (value) {
                                        if (value!.isNotEmpty) {
                                          focusNodes[5].requestFocus();
                                          _deliveryAuthConfirmCodeBloc.add(
                                              EditingCode(textControllers[0]
                                                      .value
                                                      .text +
                                                  textControllers[1]
                                                      .value
                                                      .text +
                                                  textControllers[2]
                                                      .value
                                                      .text +
                                                  textControllers[3]
                                                      .value
                                                      .text +
                                                  textControllers[4]
                                                      .value
                                                      .text +
                                                  textControllers[5]
                                                      .value
                                                      .text));
                                        }
                                      })),
                              const SizedBox(width: 5),
                              Expanded(
                                  child: DeliveryAuthConfirmCodeTextfield(
                                      controller: textControllers[5],
                                      focusNode: focusNodes[5],
                                      isError: isError,
                                      onChanged: (value) {
                                        _deliveryAuthConfirmCodeBloc.add(
                                            EditingCode(textControllers[0]
                                                    .value
                                                    .text +
                                                textControllers[1].value.text +
                                                textControllers[2].value.text +
                                                textControllers[3].value.text +
                                                textControllers[4].value.text +
                                                textControllers[5].value.text));
                                      })),
                              const SizedBox(width: 5),
                              const SizedBox(width: 24),
                            ],
                          ),
                        )
                      ]),
                  const SizedBox(height: 10),
                  BlocBuilder<DeliveryAuthConfirmCodeBloc,
                          DeliveryAuthConfirmCodeState>(
                      bloc: _deliveryAuthConfirmCodeBloc,
                      builder: (context, state) {
                        if (state is DeliveryAuthConfirmCodeFail) {
                          return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: columnHorizontalPadding),
                              child: Text(state.errorText,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontFamily: "GT-Eesti-Pro-Display",
                                      fontWeight: FontWeight.w300,
                                      color: Color.fromRGBO(255, 44, 44, 1),
                                      height: 0.9)));
                        } else {
                          return const Text("",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: "GT-Eesti-Pro-Display",
                                  fontWeight: FontWeight.w300,
                                  color: Color.fromRGBO(255, 255, 255, 0),
                                  height: 0.9));
                        }
                      }),
                  Center(
                      child: TextButton(
                          onPressed: () {
                            _deliveryAuthConfirmCodeBloc.add(LoadingResendCode(
                                userName, unMaskedPhoneNumber));
                          },
                          child: const Text(
                            "Отправить код повторно",
                            style: TextStyle(
                                color: Color.fromRGBO(56, 144, 208, 1)),
                          ))),
                  BlocBuilder<DeliveryAuthConfirmCodeBloc,
                          DeliveryAuthConfirmCodeState>(
                      bloc: _deliveryAuthConfirmCodeBloc,
                      builder: (context, state) {
                        if (state is DeliveryAuthConfirmCodeResendFail) {
                          return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: columnHorizontalPadding),
                              child: Text(state.errorText,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontFamily: "GT-Eesti-Pro-Display",
                                      fontWeight: FontWeight.w300,
                                      color: Color.fromRGBO(255, 44, 44, 1),
                                      height: 0.9)));
                        } else if (state
                            is DeliveryAuthConfirmCodeResendSuccess) {
                          return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: columnHorizontalPadding),
                              child: const Text('Код успешно отправлен',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: "GT-Eesti-Pro-Display",
                                      fontWeight: FontWeight.w300,
                                      color: Colors.green,
                                      height: 0.9)));
                        } else {
                          return const SizedBox.shrink();
                        }
                      }),
                  const Spacer(),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: columnHorizontalPadding),
                      child: SizedBox(
                        width: double.infinity,
                        child: BlocBuilder<DeliveryAuthConfirmCodeBloc,
                                DeliveryAuthConfirmCodeState>(
                            bloc: _deliveryAuthConfirmCodeBloc,
                            builder: (context, state) {
                              if (state is DeliveryAuthConfirmCodeWritten) {
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
                                          if (_firstTextFieldController.value.text.isNotEmpty &&
                                              _secondTextFieldController
                                                  .value.text.isNotEmpty &&
                                              _thirdTextFieldController
                                                  .value.text.isNotEmpty &&
                                              _fourTextFieldController
                                                  .value.text.isNotEmpty &&
                                              _fiveTextFieldController
                                                  .value.text.isNotEmpty &&
                                              _sixTextFieldController
                                                  .value.text.isNotEmpty) {
                                            final code = _firstTextFieldController
                                                    .value.text +
                                                _secondTextFieldController
                                                    .value.text +
                                                _thirdTextFieldController
                                                    .value.text +
                                                _fourTextFieldController
                                                    .value.text +
                                                _fiveTextFieldController
                                                    .value.text +
                                                _sixTextFieldController
                                                    .value.text;
                                            print(code);
                                            _deliveryAuthConfirmCodeBloc.add(
                                                LoadingConfirmCodeRequest(
                                                    code, unMaskedPhoneNumber));
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.symmetric(
                                              vertical: buttonHeight),
                                          backgroundColor: Colors
                                              .transparent, // Чтобы фон ElevatedButton был прозрачным
                                          elevation:
                                              0, // Отключаем подъем тени кнопки
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                        ),
                                        child: const Text(
                                          'Зарегистрироваться',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily:
                                                  "GT-Eesti-Pro-Display",
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400),
                                        )));
                              } else {
                                return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                          vertical: buttonHeight),
                                      backgroundColor: const Color.fromRGBO(
                                          195, 195, 195, 1)),
                                  onPressed: () {},
                                  child: const Text(
                                    'Зарегистрироваться',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "GT-Eesti-Pro-Display",
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
                                  ),
                                );
                              }
                            }),
                      )),
                  const SizedBox(height: 40)
                ],
              ),
            ),
          ),
          backgroundColor: Colors.white,
        ));
  }
}
