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
        emit(ProfileLoadedState(profile: response));
      } catch (e) {
        emit(MyProfileErrorState(error: e.toString()));
      }
    });

    on<GetProfessionsEvent>((event, emit) async {
      emit(MyProfileLoadingState());
      try {
        final response = await profileService.getProfessions();
        emit(ProfessionsLoadedState(professions: response));
      } catch (e) {
        emit(MyProfileErrorState(error: e.toString()));
      }
    });

    on<GetSentimentalSituationsEvent>((event, emit) async {
      emit(MyProfileLoadingState());
      try {
        final response = await profileService.getSentimentalSituations();
        emit(SentimentalSituationsLoadedState(sentimentalSituations: response));
      } catch (e) {
        emit(MyProfileErrorState(error: e.toString()));
      }
    });

    on<UpdateSexEvent>((event, emit) async {
      emit(MyProfileLoadingState());
      try {
        final response = await profileService.updateSex(event.sex);
        emit(MyProfileUpdatedState(response: response, field: 'sex'));
      } catch (e) {
        emit(MyProfileErrorState(error: e.toString()));
      }
    });
  }
}
