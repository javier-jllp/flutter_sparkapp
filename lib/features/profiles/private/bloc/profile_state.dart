abstract class MyProfileState {}

// Estado inicial
class MyProfileInitialState extends MyProfileState {}

// Estado de carga
class MyProfileLoadingState extends MyProfileState {}

// Estado de error
class MyProfileErrorState extends MyProfileState {
  final String error;
  MyProfileErrorState({required this.error});
}

// Estado con datos del perfil
class ProfileLoadedState extends MyProfileState {
  final Map<String, dynamic> profile;
  ProfileLoadedState({required this.profile});
}

// Estado con lista de profesiones
class ProfessionsLoadedState extends MyProfileState {
  final List<Map<String, dynamic>> professions;
  ProfessionsLoadedState({required this.professions});
}

// Estado con lista de situaciones sentimentales
class SentimentalSituationsLoadedState extends MyProfileState {
  final List<Map<String, dynamic>> sentimentalSituations;
  SentimentalSituationsLoadedState({required this.sentimentalSituations});
}

// Estado para las actualizaciones
class MyProfileUpdatedState extends MyProfileState {
  final Map<String, dynamic> response;
  final String field; // Campo actualizado
  MyProfileUpdatedState({required this.response, required this.field});
}
