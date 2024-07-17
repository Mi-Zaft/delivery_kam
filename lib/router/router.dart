import 'package:delivery_kam/features/auth/confirm_code/view/delivery_auth_confirm_code_screen.dart';
import 'package:delivery_kam/features/auth/login/view/delivery_auth_login_screen.dart';
import 'package:delivery_kam/features/auth/register/delivery_auth_register.dart';
import 'package:delivery_kam/features/be_courier/view/be_courier_screen.dart';
import 'package:delivery_kam/features/main/delivery_main_screen.dart';
import 'package:delivery_kam/features/main/view/check_auth_screen.dart';
import 'package:delivery_kam/features/main/view/delivery_main_order_details_edit.dart';
import 'package:delivery_kam/features/order_active/view/order_active_screen.dart';
import 'package:delivery_kam/features/order_active/view/order_cancel_reason_screen.dart';
import 'package:delivery_kam/features/order_history/view/order_history_list_screen.dart';
import 'package:delivery_kam/features/payment_add/view/delivery_payment_add_screen.dart';
import 'package:delivery_kam/features/payment_list/view/delivery_payment_list_screen.dart';
// import '../features/courier_chat/view/view.dart';

final routes = {
  '/': (context) => const CheckAuthScreen(),
  '/be-courier': (context) => const BeCourierScreen(),
  '/register': (context) => const DeliveryAuthRegisterScreen(),
  '/register-confirm': (context) => const DeliveryAuthConfirmCodeScreen(),
  '/login': (context) => const DeliveryAuthLoginScreen(),
  '/main-screen': (context) => const DeliveryMainScreen(),
  '/payment-list': (context) => const DeliveryPaymentListScreen(),
  '/payment-add': (context) => const DeliveryPaymentAddScreen(),
  '/order-history-list': (context) => const OrderHistoryListScreen(),
  '/order-adress-details-edit': (context) =>
      const DeliveryMainOrderDetailsEdit(),
  '/order-active': (context) => const OrderActiveScreen(),
  '/order-cancel-reason': (context) => const OrderCancelReasonScreen()
};
