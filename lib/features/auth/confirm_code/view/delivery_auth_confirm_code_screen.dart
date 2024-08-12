import 'package:delivery_kam/features/auth/confirm_code/bloc/delivery_auth_confirm_code_bloc.dart';
import 'package:delivery_kam/features/auth/confirm_code/widgets/delivery_auth_confirm_code_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeliveryAuthConfirmCodeScreen extends StatefulWidget {
  const DeliveryAuthConfirmCodeScreen({super.key});

  @override
  State<DeliveryAuthConfirmCodeScreen> createState() =>
      _DeliveryAuthConfirmCodeScreenState();
}

class _DeliveryAuthConfirmCodeScreenState
    extends State<DeliveryAuthConfirmCodeScreen> {
  final _deliveryAuthConfirmCodeBloc = DeliveryAuthConfirmCodeBloc();
  final double buttonHeight = 15; // Высота кнопок
  final double columnHorizontalPadding =
      24.0; // Отступы по бокам столбца кнопок
  final _focus = FocusNode();
  final TextEditingController _codeTextFieldController =
      TextEditingController();
  bool isError = false;

  late List<TextEditingController> textControllers;
  late List<FocusNode> focusNodes;

  void _handleBoxPressed() {
    _focus.requestFocus();
  }

  void _controllerListener() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    _codeTextFieldController.addListener(_controllerListener);
  }

  @override
  void dispose() {
    _codeTextFieldController.removeListener(_controllerListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final code = _codeTextFieldController.text.padRight(6).split('');
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String phoneNumber = args['phoneNumber'];
    final String? userName = args['userName'];
    final String unMaskedPhoneNumber = args['unMaskedPhoneNumber'];
    return BlocProvider(
        create: (BuildContext context) => DeliveryAuthConfirmCodeBloc(),
        child: Scaffold(
          appBar: AppBar(
            title: userName != null
                ? const Text("Регистрация")
                : const Text("Авторизация"),
            iconTheme:
                const IconThemeData(color: Color.fromRGBO(149, 149, 149, 1)),
          ),
          body: BlocListener<DeliveryAuthConfirmCodeBloc,
              DeliveryAuthConfirmCodeState>(
            bloc: _deliveryAuthConfirmCodeBloc,
            listener: (context, state) {
              if (state is DeliveryAuthConfirmCodeSuccess) {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/main-screen', (route) => false);
              } else if (state is HasActiveOrder) {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/order-active', (route) => false,
                    arguments: {'order': state.order});
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
                        color: Color(0xff7A7A7A),
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
                        color: Color(0xff7A7A7A),
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  Offstage(
                    child: TextField(
                      focusNode: _focus,
                      controller: _codeTextFieldController,
                      onChanged: (value) => {
                        _deliveryAuthConfirmCodeBloc
                            .add(EditingCode(_codeTextFieldController.text))
                      },
                      autofocus: true,
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                    ),
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BlocProvider.value(
                          value: _deliveryAuthConfirmCodeBloc,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: columnHorizontalPadding),
                            child: Row(
                              children: [
                                Expanded(
                                  child: DeliveryAuthConfirmCodeTextField(
                                    onPressed: _handleBoxPressed,
                                    value: code[0],
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: DeliveryAuthConfirmCodeTextField(
                                    onPressed: _handleBoxPressed,
                                    value: code[1],
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: DeliveryAuthConfirmCodeTextField(
                                    onPressed: _handleBoxPressed,
                                    value: code[2],
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: DeliveryAuthConfirmCodeTextField(
                                    onPressed: _handleBoxPressed,
                                    value: code[3],
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: DeliveryAuthConfirmCodeTextField(
                                    onPressed: _handleBoxPressed,
                                    value: code[4],
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: DeliveryAuthConfirmCodeTextField(
                                    onPressed: _handleBoxPressed,
                                    value: code[5],
                                  ),
                                ),
                              ],
                            ),
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
                                      fontWeight: FontWeight.w300,
                                      color: Color.fromRGBO(255, 44, 44, 1),
                                      height: 0.9)));
                        } else {
                          return const Text("",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  color: Color.fromRGBO(255, 255, 255, 0),
                                  height: 0.9));
                        }
                      }),
                  Center(
                      child: TextButton(
                          onPressed: () {
                            _deliveryAuthConfirmCodeBloc.add(
                                LoadingResendCode(null, unMaskedPhoneNumber));
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
                                  if (_codeTextFieldController.text.length ==
                                      6) {
                                    final code = _codeTextFieldController.text;
                                    if (userName != null) {
                                      _deliveryAuthConfirmCodeBloc.add(
                                        LoadingConfirmCodeRequest(
                                            code, unMaskedPhoneNumber),
                                      );
                                    } else {
                                      _deliveryAuthConfirmCodeBloc.add(
                                        LoadingAuthConfirmCodeRequest(
                                            code, unMaskedPhoneNumber),
                                      );
                                    }
                                  }
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
                                child: Text(
                                  userName != null
                                      ? 'Зарегистрироваться'
                                      : 'Войти',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            );
                          } else {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      vertical: buttonHeight),
                                  backgroundColor:
                                      const Color.fromRGBO(195, 195, 195, 1)),
                              onPressed: () {},
                              child: Text(
                                userName != null
                                    ? 'Зарегистрироваться'
                                    : 'Войти',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 40)
                ],
              ),
            ),
          ),
          backgroundColor: Colors.white,
        ));
  }
}
