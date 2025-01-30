import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/notification_bloc/notification_bloc.dart';
import '../services/fcm_service.dart';

final fcmBlocProvider = Provider<FCMBloc>((ref) {
  return FCMBloc(FCMService());
});