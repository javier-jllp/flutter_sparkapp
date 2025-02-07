abstract class MyProfileState {}

// Estado inicial
class MyProfileInitialState extends MyProfileState {}

// Estado de carga
class MyProfileLoadingState extends MyProfileState {}

// Estado de error
class MyProfileErrorState extends MyProfileState {
  final String errorMessage;
  MyProfileErrorState({required this.errorMessage});
}

// Estado para modelos y retorno de lista
class MyProfileLoadedState extends MyProfileState {
  final Map<String, dynamic> profile;
  MyProfileLoadedState({required this.profile});
}

class MyProfileInfoAdditionalLoadedState extends MyProfileState {
  final Map<String, dynamic> profileInfoAdditional;
  MyProfileInfoAdditionalLoadedState({required this.profileInfoAdditional});
}

class HobbiesLoadedState extends MyProfileState {
  final List<Map<String, dynamic>> hobbies;
  HobbiesLoadedState({required this.hobbies});
}

class SexLoadedState extends MyProfileState {
  final List<Map<String, dynamic>> sexes;
  SexLoadedState({required this.sexes});
}

class SeeksLoadedState extends MyProfileState {
  final List<Map<String, dynamic>> seeks;
  SeeksLoadedState({required this.seeks});
}

class SmokingHabitLoadedState extends MyProfileState {
  final List<Map<String, dynamic>> smokingHabits;
  SmokingHabitLoadedState({required this.smokingHabits});
}

class DrinkingHabitLoadedState extends MyProfileState {
  final List<Map<String, dynamic>> drinkingHabits;
  DrinkingHabitLoadedState({required this.drinkingHabits});
}


// Estado para las actualizaciones con retorno simple como json 
class MyProfileUpdatedState extends MyProfileState {
  final Map<String, dynamic> response;
  final String field; // Campo actualizado
  MyProfileUpdatedState({required this.response, required this.field});
}
