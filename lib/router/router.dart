import 'package:delivery_kam/features/auth/confirm_code/view/delivery_auth_confirm_code_screen.dart';
import 'package:delivery_kam/features/auth/login/view/delivery_auth_login_screen.dart';
import 'package:delivery_kam/features/auth/register/delivery_auth_register.dart';
import 'package:delivery_kam/features/main/delivery_main_screen.dart';
import 'package:delivery_kam/features/main/view/check_auth_screen.dart';
import 'package:delivery_kam/features/payment_list/view/delivery_payment_list_screen.dart';

final routes = {
  '/': (context) => const CheckAuthScreen(),
  '/register': (context) => const DeliveryAuthRegisterScreen(),
  '/register-confirm': (context) => const DeliveryAuthConfirmCodeScreen(),
  '/login': (context) => const DeliveryAuthLoginScreen(),
  '/main-screen': (context) => const DeliveryMainScreen(),
  '/payment-list': (context) => const DeliveryPaymentListScreen(),
};
