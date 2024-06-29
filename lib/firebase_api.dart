import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();

    final fCMToken = await _firebaseMessaging.getToken();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (fCMToken != null) {
      await prefs.setString('fcmToken', fCMToken);
    }
  }
}
