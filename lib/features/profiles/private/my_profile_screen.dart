import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sparkapp/my_widgets/image_view.dart';

import './bloc/profile_bloc.dart';
import './bloc/profile_state.dart';
import './provider.dart';
import '../../../settings/app_config.dart';

// import widgets
import './widgets/profile_photo.dart';
import './widgets/full_name.dart';

class MyProfileScreen extends ConsumerWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final blocProvider = ref.watch(myProfileBlocProvider);

    return blocProvider.when(
      data: (bloc) {
        return BlocBuilder(
          bloc: bloc,
          builder: (context, state) => _initial(bloc, context),
        );
      },
      error: (rror, StackTrace stackTrace) => const Text('Error'),
      loading: () => const CircularProgressIndicator(),
    );
  }
}

Widget _initial(MyProfileBloc bloc, BuildContext context) {
  final state = bloc.state;
  if (state is MyProfileLoadingState) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  } else if (state is MyProfileLoadedState) {
    return _builMydProfileInfo(bloc, state.profile, context);
  } else {
    return const Text('Error');
  }
}

Widget _builMydProfileInfo(MyProfileBloc bloc, Map<String, dynamic> profile,
    BuildContext context) {
  final AppConfig appConfig = AppConfig();
  final urlProfilePhoto =
      '${appConfig.endpointS3}/${profile['profile_photo_path']}';
  return Container(
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              TextButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => ImageView(
                            url: urlProfilePhoto,
                          ));
                },
                child: profilePhoto(bloc, context, urlProfilePhoto),
              ),
              const SizedBox(
                height: 20,
              ),
              fullName(bloc, context, profile['user']['full_name']),
              const SizedBox(height: 10),
            ],
          )));
}

Widget _buildMyProfileAdditionalInfo(Map<String, dynamic> profile) {
  return Column(
    children: [
      Text(profile['view_count']),
    ],
  );
}

Widget _buildHobbiesInfo(List<Map<String, dynamic>> hobbies) {
  return Column(
    children: [
      Text(hobbies[0]['name']),
    ],
  );
}

Widget _buildSexesInfo(List<Map<String, dynamic>> sexes) {
  return Column(
    children: [
      Text(sexes[0]['name']),
    ],
  );
}

Widget _buildSeeksInfo(List<Map<String, dynamic>> seeks) {
  return Column(
    children: [
      Text(seeks[0]['name']),
    ],
  );
}

Widget _buildSmokingHabitsInfo(List<Map<String, dynamic>> smokingHabits) {
  return Column(
    children: [
      Text(smokingHabits[0]['name']),
    ],
  );
}

Widget _buildDrinkingHabitsInfo(List<Map<String, dynamic>> drinkingHabits) {
  return Column(
    children: [
      Text(drinkingHabits[0]['name']),
    ],
  );
}
