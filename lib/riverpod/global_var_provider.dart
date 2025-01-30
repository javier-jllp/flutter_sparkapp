import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../settings/app_config.dart';

final globalVarProvider = Provider<AppConfig>((ref) => AppConfig());
