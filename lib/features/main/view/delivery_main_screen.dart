import 'package:delivery_kam/features/main/bloc/delivery_main_bloc.dart';
import 'package:delivery_kam/features/main/view/delivery_main_map_screen.dart';
import 'package:delivery_kam/features/main/widgets/delivery_main_drawer.dart';
import 'package:flutter/material.dart';
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
  final double maxChildSize = 0.9;
  final double minChildSize = .39;

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
      body: Stack(children: [DeliveryMainMapScreen(openDrawer: openDrawer),
      ]),
    );
  }
}
