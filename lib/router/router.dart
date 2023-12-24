import 'package:delivery_kam/features/auth/choose/delivery_auth_choose.dart';
import 'package:delivery_kam/features/auth/confirm_code/view/delivery_auth_confirm_code_screen.dart';
import 'package:delivery_kam/features/auth/register/delivery_auth_register.dart';

final routes = {
  '/': (context) => const DeliveryAuthChooseScreen(),
  '/register': (context) => const DeliveryAuthRegisterScreen(),
  '/register-confirm': (context) => const DeliveryAuthConfirmCodeScreen(),
};
