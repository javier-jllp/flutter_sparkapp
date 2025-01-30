import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:sparkapp/firebase_options.dart';
import 'package:sparkapp/app.dart';

void main(List<String> args) async {
  //Iniciar la aplicacion de firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const ProviderScope(child: SparkApp()),
  );
}
