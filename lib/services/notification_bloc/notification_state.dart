abstract class FCMState {}

class FCMInitialState extends FCMState {}

class FCMTokenState extends FCMState {
  final String token;
  FCMTokenState({required this.token});
}

class FCMErrorState extends FCMState {
  final String error;
  FCMErrorState({required this.error});
}