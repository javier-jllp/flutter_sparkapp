abstract class MyProfileEvent {}

class GetMeProfileEvent extends MyProfileEvent {}

class GetProfessionsEvent extends MyProfileEvent {}

class GetSentimentalSituationsEvent extends MyProfileEvent {}

class UpdateSexEvent extends MyProfileEvent {
  final String sex;
  UpdateSexEvent({required this.sex});
}

class UpdateBirthdateEvent extends MyProfileEvent {
  final String birthdate;
  UpdateBirthdateEvent({required this.birthdate});
}

class UpdateProfilePhotoEvent extends MyProfileEvent {
  final String profilePhotoPath;
  UpdateProfilePhotoEvent({required this.profilePhotoPath});
}

class UpdateBioEvent extends MyProfileEvent {
  final String bio;
  UpdateBioEvent({required this.bio});
}

class AddProfessionEvent extends MyProfileEvent {
  final int professionId;
  AddProfessionEvent({required this.professionId});
}

class UpdateSentimentalSituationEvent extends MyProfileEvent {
  final int sentimentalSituationId;
  UpdateSentimentalSituationEvent({required this.sentimentalSituationId});
}