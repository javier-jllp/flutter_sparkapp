import 'package:firebase_messaging/firebase_messaging.dart';

class FCMService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    // request permission from user (will prompt user)
    final NotificationSettings settings =
        await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
      announcement: false,
      carPlay: false,
      criticalAlert: false,
    );

    print('User granted permission: ${settings.authorizationStatus}');

    // Configurar el listener para escuchar las notificaciones en segundo plano
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      onMessage(message);
    });

    // Configurar el listener para escuchar las notificaciones en primer plano
    // o cuando este se abre la app desde una notificación
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      onMessageOpenedApp(message);
    });
  }

  Future<String> getToken() async {
    String fcmToken = await _firebaseMessaging.getToken() ?? '';
    return fcmToken;
  }

  // Aquí puedes manejar la lógica cuando se abre la app desde una notificación
  Future<void> onMessageOpenedApp(RemoteMessage message) async {
    //...
  }

  // Aquí puedes manejar la lógica cuando se recibe una notificación en segundo plano
  Future<void> onMessage(RemoteMessage message) async {
    print('Message Title: ${message.notification?.title}');
    print('Message Body: ${message.notification?.body}');

    // Mostrar la notificacion como una notificacion push
  }
}