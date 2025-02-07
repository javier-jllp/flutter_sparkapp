import 'package:flutter_bloc/flutter_bloc.dart';

import '../service.dart';
import './profile_event.dart';
import './profile_state.dart';

class MyProfileBloc extends Bloc<MyProfileEvent, MyProfileState> {
  final MyProfileService profileService;

  MyProfileBloc({required this.profileService})
      : super(MyProfileInitialState()) {
    on<GetMeProfileEvent>((event, emit) async {
      emit(MyProfileLoadingState());
      try {
        final response = await profileService.getMeProfile();
        emit(MyProfileLoadedState(profile: response));
      } catch (e) {
        emit(MyProfileErrorState(errorMessage: e.toString()));
      }
    });

    on<GetMeProfileInfoAdditionalEvent>((event, emit) async {
      emit(MyProfileLoadingState());
      try {
        final response = await profileService.getMeProfileInfoAdditional();
        emit(MyProfileInfoAdditionalLoadedState(
            profileInfoAdditional: response));
      } catch (e) {
        emit(MyProfileErrorState(errorMessage: e.toString()));
      }
    });

    on<GetHobbiesEvent>((event, emit) async {
      emit(MyProfileLoadingState());
      try {
        final response = await profileService.getHobbies();
        emit(HobbiesLoadedState(hobbies: response));
      } catch (e) {
        emit(MyProfileErrorState(errorMessage: e.toString()));
      }
    });

    on<GetSexEvent>((event, emit) async {
      emit(MyProfileLoadingState());
      try {
        final response = await profileService.getSexes();
        emit(SexLoadedState(sexes: response));
      } catch (e) {
        emit(MyProfileErrorState(errorMessage: e.toString()));
      }
    });

    on<GetSeeksEvent>((event, emit) async {
      emit(MyProfileLoadingState());
      try {
        final response = await profileService.getSeeks();
        emit(SeeksLoadedState(seeks: response));
      } catch (e) {
        emit(MyProfileErrorState(errorMessage: e.toString()));
      }
    });

    on<GetSmokingHabitEvent>((event, emit) async {
      emit(MyProfileLoadingState());
      try {
        final response = await profileService.getSmokingHabits();
        emit(SmokingHabitLoadedState(smokingHabits: response));
      } catch (e) {
        emit(MyProfileErrorState(errorMessage: e.toString()));
      }
    });

    on<GetDrinkingHabitEvent>((event, emit) async {
      emit(MyProfileLoadingState());
      try {
        final response = await profileService.getDrinkingHabits();
        emit(DrinkingHabitLoadedState(drinkingHabits: response));
      } catch (e) {
        emit(MyProfileErrorState(errorMessage: e.toString()));
      }
    });

    on<UpdateSexEvent>((event, emit) async {
      emit(MyProfileLoadingState());
      try {
        final response = await profileService.updateSex(event.sexId);
        emit(MyProfileUpdatedState(response: response, field: 'sex'));
        add(GetMeProfileEvent());
      } catch (e) {
        emit(MyProfileErrorState(errorMessage: e.toString()));
      }
    });

    on<UpdateSexOrientationEvent>((event, emit) async {
      emit(MyProfileLoadingState());
      try {
        final response =
            await profileService.updateSexOrientation(event.sexOrientationId);
        emit(MyProfileUpdatedState(
            response: response, field: 'sex_orientation'));
        add(GetMeProfileEvent());
      } catch (e) {
        emit(MyProfileErrorState(errorMessage: e.toString()));
      }
    });

    on<UpdateSeeksEvent>((event, emit) async {
      emit(MyProfileLoadingState());
      try {
        final response = await profileService.updateSeeks(event.seeksId);
        emit(MyProfileUpdatedState(response: response, field: 'seeks'));
        add(GetMeProfileEvent());
      } catch (e) {
        emit(MyProfileErrorState(errorMessage: e.toString()));
      }
    });

    on<UpdateSmokingHabitEvent>((event, emit) async {
      emit(MyProfileLoadingState());
      try {
        final response =
            await profileService.updateSmokingHabit(event.smokingHabitId);
        emit(MyProfileUpdatedState(response: response, field: 'smoking_habit'));
        add(GetMeProfileEvent());
      } catch (e) {
        emit(MyProfileErrorState(errorMessage: e.toString()));
      }
    });

    on<UpdateDrinkingHabitEvent>((event, emit) async {
      emit(MyProfileLoadingState());
      try {
        final response =
            await profileService.updateDrinkingHabit(event.drinkingHabitId);
        emit(
            MyProfileUpdatedState(response: response, field: 'drinking_habit'));
        add(GetMeProfileEvent());
      } catch (e) {
        emit(MyProfileErrorState(errorMessage: e.toString()));
      }
    });

    on<UpdateLocationEvent>((event, emit) async {
      emit(MyProfileLoadingState());
      try {
        final response = await profileService.updateLocation(
            event.latitude, event.longitude);
        emit(MyProfileUpdatedState(response: response, field: 'location'));
        add(GetMeProfileEvent());
      } catch (e) {
        emit(MyProfileErrorState(errorMessage: e.toString()));
      }
    });

    on<UpdateBirthdateEvent>((event, emit) async {
      emit(MyProfileLoadingState());
      try {
        final response = await profileService.updateBirthdate(event.birthdate);
        emit(MyProfileUpdatedState(response: response, field: 'birthdate'));
        add(GetMeProfileEvent());
      } catch (e) {
        emit(MyProfileErrorState(errorMessage: e.toString()));
      }
    });

    on<UpdateProfilePhotoEvent>((event, emit) async {
      emit(MyProfileLoadingState());
      try {
        final response = await profileService.updateProfilePhoto(event.file);
        emit(MyProfileUpdatedState(response: response, field: 'profile_photo'));
        add(GetMeProfileEvent());
      } catch (e) {
        emit(MyProfileErrorState(errorMessage: e.toString()));
      }
    });

    on<UpdateBioEvent>((event, emit) async {
      emit(MyProfileLoadingState());
      try {
        final response = await profileService.updateBio(event.bio);
        emit(MyProfileUpdatedState(response: response, field: 'bio'));
        add(GetMeProfileEvent());
      } catch (e) {
        emit(MyProfileErrorState(errorMessage: e.toString()));
      }
    });

    on<UpdateStatureEvent>((event, emit) async {
      emit(MyProfileLoadingState());
      try {
        final response = await profileService.updateStature(event.stature);
        emit(MyProfileUpdatedState(response: response, field: 'stature'));
        add(GetMeProfileEvent());
      } catch (e) {
        emit(MyProfileErrorState(errorMessage: e.toString()));
      }
    });

    on<AddNewHobbyEvent>((event, emit) async {
      emit(MyProfileLoadingState());
      try {
        final response = await profileService.addNewHobby(event.hobbyId);
        emit(MyProfileUpdatedState(response: response, field: 'hobbies'));
        add(GetMeProfileEvent());
      } catch (e) {
        emit(MyProfileErrorState(errorMessage: e.toString()));
      }
    });

    on<RemoveHobbyEvent>((event, emit) async {
      emit(MyProfileLoadingState());
      try {
        final response = await profileService.removeHobby(event.hobbyId);
        emit(MyProfileUpdatedState(response: response, field: 'hobbies'));
        add(GetMeProfileEvent());
      } catch (e) {
        emit(MyProfileErrorState(errorMessage: e.toString()));
      }
    });

    on<UpdateFullNameEvent>((event, emit) async {
      emit(MyProfileLoadingState());
      try {
        final response = await profileService.updateFullName(event.fullName);
        emit(MyProfileUpdatedState(response: response, field: 'full_name'));
        add(GetMeProfileEvent());
      } catch (e) {
        emit(MyProfileErrorState(errorMessage: e.toString()));
      }
    });

    on<UpdatePhoneNumberEvent>((event, emit) async {
      emit(MyProfileLoadingState());
      try {
        final response =
            await profileService.updatePhoneNumber(event.phoneNumber);
        emit(MyProfileUpdatedState(response: response, field: 'phone_number'));
        add(GetMeProfileEvent());
      } catch (e) {
        emit(MyProfileErrorState(errorMessage: e.toString()));
      }
    });
  }
}
