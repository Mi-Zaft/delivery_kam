import 'package:delivery_kam/features/auth/register/bloc/delivery_auth_register_bloc.dart';
import 'package:delivery_kam/features/auth/register/widgets/delivery_auth_register_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class DeliveryAuthRegisterScreen extends StatefulWidget {
  const DeliveryAuthRegisterScreen({Key? key}) : super(key: key);

  @override
  State<DeliveryAuthRegisterScreen> createState() =>
      _DeliveryAuthRegisterScreenState();
}

class _DeliveryAuthRegisterScreenState
    extends State<DeliveryAuthRegisterScreen> {
  final _deliveryAuthRegisterBloc = DeliveryAuthRegisterBloc();
  final double columnHorizontalPadding =
      24.0; // Отступы по бокам столбца кнопок
  final TextEditingController _nameTextFieldController =
      TextEditingController();
  final TextEditingController _phoneTextFieldController =
      TextEditingController();
  final double buttonHeight = 15; // Высота кнопок
  final bottomText =
      "Вы получите на свой телефон сообщение с кодом, чтобы его подтвердить. За отправку сообщения может взиматься дополнительная плата.";

  var phoneMaskFormatter = MaskTextInputFormatter(
      mask: '+7 (###) ###-##-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  @override
  void dispose() {
    _nameTextFieldController.dispose();
    _phoneTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<DeliveryAuthRegisterBloc, DeliveryAuthRegisterState>(
          bloc: _deliveryAuthRegisterBloc,
          listener: (context, state) {
            if (state is DeliveryAuthRegisterSuccess) {
              Navigator.pushNamed(context, '/register-confirm', arguments: {
                'phoneNumber': phoneMaskFormatter.getMaskedText(),
                'userName': _nameTextFieldController.value.text,
                'unMaskedPhoneNumber': phoneMaskFormatter.getUnmaskedText()
              });
            }
          },
          child: Center(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: columnHorizontalPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(children: [
                    DeliveryAuthRegisterTextfield(
                      onChanged: () {
                        _deliveryAuthRegisterBloc.add(
                          EditingPhoneNumber(_nameTextFieldController.text,
                              _phoneTextFieldController.text),
                        );
                      },
                      labelText: "Введите имя",
                      controller: _nameTextFieldController,
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                    ),
                    const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10)),
                    DeliveryAuthRegisterTextfield(
                      onChanged: () {
                        _deliveryAuthRegisterBloc.add(
                          EditingPhoneNumber(_nameTextFieldController.text,
                              _phoneTextFieldController.text),
                        );
                      },
                      labelText: 'Введите свой номер телефона',
                      controller: _phoneTextFieldController,
                      keyboardType: TextInputType.phone,
                      textCapitalization: TextCapitalization.none,
                      inputFormatters: [phoneMaskFormatter],
                    ),
                    const Padding(padding: EdgeInsets.only(top: 7)),
                    BlocBuilder<DeliveryAuthRegisterBloc,
                            DeliveryAuthRegisterState>(
                        bloc: _deliveryAuthRegisterBloc,
                        builder: (context, state) {
                          if (state is DeliveryAuthRegisterFail) {
                            return Text(state.errorText,
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color: Color.fromRGBO(255, 44, 44, 1),
                                    height: 0.9));
                          } else {
                            return const SizedBox.shrink();
                          }
                        }),
                  ]),
                  Column(children: [
                    Text(
                      bottomText,
                      style: const TextStyle(
                          color: Color.fromRGBO(122, 122, 122, 1),
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<DeliveryAuthRegisterBloc,
                        DeliveryAuthRegisterState>(
                      bloc: _deliveryAuthRegisterBloc,
                      builder: (context, state) {
                        if (state is DeliveryAuthRegisterDataCorrect) {
                          return SizedBox(
                            width: double.infinity,
                            child: Container(
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
                                  String name = _nameTextFieldController.text;
                                  _deliveryAuthRegisterBloc.add(
                                      LoadingRegisterRequest(
                                          name,
                                          phoneMaskFormatter
                                              .getUnmaskedText()));
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      vertical: buttonHeight),
                                  backgroundColor: Colors
                                      .transparent, // Чтобы фон ElevatedButton был прозрачным
                                  elevation: 0, // Отключаем подъем тени кнопки
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                                child: const Text(
                                  'Создать аккаунт',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      vertical: buttonHeight),
                                  backgroundColor:
                                      const Color.fromRGBO(195, 195, 195, 1)),
                              onPressed: () {},
                              child: const Text(
                                'Создать аккаунт',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 40)
                  ])
                ],
              ),
            ),
          )),
      appBar: AppBar(
        title: const Text("Регистрация",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w400,
            )),
        iconTheme: const IconThemeData(color: Color.fromRGBO(149, 149, 149, 1)),
      ),
      backgroundColor: Colors.white,
    );
  }
}
