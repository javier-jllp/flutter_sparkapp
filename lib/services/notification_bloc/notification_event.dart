import 'package:firebase_messaging/firebase_messaging.dart';

abstract class FCMEvent {}

class FCMTokenEvent extends FCMEvent {}

class FCMNotificationEvent extends FCMEvent {
  final RemoteMessage message;
  FCMNotificationEvent(this.message);
}