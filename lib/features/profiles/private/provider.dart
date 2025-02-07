import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sparkapp/features/profiles/private/bloc/profile_event.dart';

import './bloc/profile_bloc.dart';
import './service.dart';

//Provider para el bloc con espera: se puede usar para estado con espera
final myProfileBlocProvider =
    FutureProvider<MyProfileBloc>((ref) async {
      final myProfileService = ref.watch(myProfileServiceProvider);
      final bloc = MyProfileBloc(profileService: myProfileService);

      // aqui se puede iniciar un operacion de carga inicial si es necesario.
      // por ejemplo: si tu bloc necesita obtener datos de una API al iniciar
      bloc.add(GetMeProfileEvent());

      return bloc;
    });

//provider para el bloc sin espera: se puede usar para estado sin espera
/*final myProfileBlocProvider = Provider<MyProfileBloc>((ref) {
  final myProfileService = ref.read(myProfileServiceProvider);
  return MyProfileBloc(profileService: myProfileService);
});*/

//provider para el servicio
final myProfileServiceProvider = Provider<MyProfileService>((ref) {
  return MyProfileService();
});
