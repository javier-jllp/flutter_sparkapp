import 'dart:ffi';
import 'dart:io';

abstract class MyProfileEvent {}

class GetMeProfileEvent extends MyProfileEvent {}

class GetMeProfileInfoAdditionalEvent extends MyProfileEvent {}

class GetHobbiesEvent extends MyProfileEvent {}

class GetSexEvent extends MyProfileEvent {}

class GetSeeksEvent extends MyProfileEvent {}

class GetSmokingHabitEvent extends MyProfileEvent {}

class GetDrinkingHabitEvent extends MyProfileEvent {}

class GetMyHobbiesEvent extends MyProfileEvent {}

class UpdateSexEvent extends MyProfileEvent {
  final int sexId;
  UpdateSexEvent({required this.sexId});
}

class UpdateSexOrientationEvent extends MyProfileEvent {
  final int sexOrientationId;
  UpdateSexOrientationEvent({required this.sexOrientationId});
}

class UpdateSeeksEvent extends MyProfileEvent {
  final int seeksId;
  UpdateSeeksEvent({required this.seeksId});
}

class UpdateSmokingHabitEvent extends MyProfileEvent {
  final int smokingHabitId;
  UpdateSmokingHabitEvent({required this.smokingHabitId});
}

class UpdateDrinkingHabitEvent extends MyProfileEvent {
  final int drinkingHabitId;
  UpdateDrinkingHabitEvent({required this.drinkingHabitId});
}

class UpdateLocationEvent extends MyProfileEvent {
  final Float latitude;
  final Float longitude;
  UpdateLocationEvent({required this.latitude, required this.longitude});
}

class UpdateBirthdateEvent extends MyProfileEvent {
  final String birthdate;
  UpdateBirthdateEvent({required this.birthdate});
}

class UpdateProfilePhotoEvent extends MyProfileEvent {
  final File file;
  UpdateProfilePhotoEvent({required this.file});
}

class UpdateBioEvent extends MyProfileEvent {
  final String bio;
  UpdateBioEvent({required this.bio});
}

class UpdateStatureEvent extends MyProfileEvent {
  final int stature;
  UpdateStatureEvent({required this.stature});
}

class AddNewHobbyEvent extends MyProfileEvent {
  final int hobbyId;
  AddNewHobbyEvent({required this.hobbyId});
}

class RemoveHobbyEvent extends MyProfileEvent {
  final int hobbyId;
  RemoveHobbyEvent({required this.hobbyId});
}

class UpdateFullNameEvent extends MyProfileEvent {
  final String fullName;
  UpdateFullNameEvent({required this.fullName});
}

class UpdatePhoneNumberEvent extends MyProfileEvent {
  final String phoneNumber;
  UpdatePhoneNumberEvent({required this.phoneNumber});
}

