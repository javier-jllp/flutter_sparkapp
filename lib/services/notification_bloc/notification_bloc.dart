import 'package:flutter_bloc/flutter_bloc.dart';

import 'notification_state.dart';
import 'notification_event.dart';
import '../fcm_service.dart';

class FCMBloc extends Bloc<FCMEvent, FCMState> {
  final FCMService _fcmService;

  FCMBloc(this._fcmService) : super(FCMInitialState()) {
    // Inicializar el estado
    _fcmService.initNotifications(); // Iniciar las notificaciones

    on<FCMTokenEvent>((event, emit) async {
      try {
        String fcmToken = await _fcmService.getToken();
        emit(FCMTokenState(token: fcmToken));
      } catch (e) {
        emit(FCMErrorState(error: e.toString()));
      }
    });
    on<FCMNotificationEvent>((event, emit) async {
      try {
        await _fcmService.onMessage(event.message);
      } catch (e) {
        emit(FCMErrorState(error: e.toString()));
      }
    });
  }
}
