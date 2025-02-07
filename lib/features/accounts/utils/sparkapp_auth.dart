import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../utils/dio_client.dart';
import '../../../services/fcm_service.dart';
import '../../../utils/device_info.dart';
import '../../../services/geolocator_service.dart';
import '../../../settings/app_config.dart';
import 'google_auth.dart';


final DioClient dioClient = DioClient();
final AppConfig appConfig = AppConfig();
final GoogleAuthSparkApp googleAuth = GoogleAuthSparkApp();
final FCMService fcmService = FCMService();
final GeolocatorService geolocatorService = GeolocatorService();

const storage = FlutterSecureStorage();

Future<Map<String, dynamic>?> _gatherUserData() async {
  try {
    final MyReturnSignIn user = await googleAuth.signInWithGoogle();
    final String fcmToken = await fcmService.getToken();
    final ReturnDeviceInfo deviceInfo = await getDeviceInfo();

    return {
      'fcm_token': fcmToken,
      'platform': deviceInfo.platform,
      'user_agent':
          "${deviceInfo.brand} ${deviceInfo.version} - model ${deviceInfo.model}",
      'full_name': user.fullName,
      'email': user.email,
      'phone_number': user.phoneNumber,
      'api_key': appConfig.apiKey
    };
  } catch (e) {
    throw "Error : $e"; // O lanza una excepción si prefieres
  }
}

class AuthSparkapp {
  Future<bool> loginSparkapp() async {
    const String path = '/accounts/register-and-authenticate';
    final Map<String, dynamic>? userData = await _gatherUserData();

    if (userData == null) {
      throw Exception(
          'Error al obtener datos del usuario'); // O manejarlo de otra forma
    }
    try {
      final Map<String, dynamic> response = await dioClient.postJson(path, userData);
      if (response['access_token'] == null || response['refresh_token'] == null) {
        throw Exception('Error: Los tokens de acceso no se encontraron en la respuesta'); 
      }
      await appConfig.setStorageAccessToken(response['access_token']);
      await appConfig.setStorageRefreshToken(response['refresh_token']);
      return true;
    } catch (e) {
      rethrow; // O manejar el error de forma apropiada
    }
  }

  Future<void> logoutSparkapp() async {
    await appConfig.deleteStorageAll();
  }
}


