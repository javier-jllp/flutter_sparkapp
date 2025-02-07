import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppConfig {
  static final AppConfig _instance = AppConfig._internal();
  factory AppConfig() => _instance;
  AppConfig._internal();


  String apiDomain = 'http://10.0.2.2:8000/api';
  String endpointS3 = 'https://g1n0.c12.e2-3.dev/storage-sparkapp-dev';
  String apiKey = 'pi31415926535';
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  FlutterSecureStorage get storage => _storage;

  // Métodos para acceder a los datos del almacenamiento seguro
  Future<String?> get refreshToken async => await _readSecureStorage('jl_refresh_token');
  Future<String?> get accessToken async => await _readSecureStorage('jl_access_token');
  Future<String?> get expRefreshToken async => await _readSecureStorage('jl_exp_refresh_token');
  Future<String?> get expAccessToken async => await _readSecureStorage('jl_exp_access_token');

  // Métodos para escribir en el almacenamiento seguro
  Future<void> setStorageRefreshToken(String value) async => await _writeSecureStorage('jl_refresh_token', value);
  Future<void> setStorageAccessToken(String value) async => await _writeSecureStorage('jl_access_token', value);
  Future<void> setStorageExpRefreshToken(String value) async => await _writeSecureStorage('jl_exp_refresh_token', value);
  Future<void> setStorageExpAccessToken(String value) async => await _writeSecureStorage('jl_exp_access_token', value);

  // Métodos para eliminar datos del almacenamiento seguro
  Future<void> deleteStorageRefreshToken() async => await _deleteSecureStorage('jl_refresh_token');
  Future<void> deleteStorageAccessToken() async => await _deleteSecureStorage('jl_access_token');
  Future<void> deleteStorageExpRefreshToken() async => await _deleteSecureStorage('jl_exp_refresh_token');
  Future<void> deleteStorageExpAccessToken() async => await _deleteSecureStorage('jl_exp_access_token');

  // Metodos para eliminar todos los datos en el almacenamiento
  Future<void> deleteStorageAll() async => await _deleteAllSecureStorage();


  Future<String?> _readSecureStorage(String key) async {
    try {
      return await _storage.read(key: key);
    } catch (e) {
      throw Exception('Error al leer de SecureStorage ($key): $e');
    }
  }

  Future<void> _writeSecureStorage(String key, String value) async {
    try {
      await _storage.write(key: key, value: value);
    } catch (e) {
      throw Exception('Error al escribir en SecureStorage ($key): $e');
    }
  }

  Future<void> _deleteSecureStorage(String key) async {
    try {
      await _storage.delete(key: key);
    } catch (e) {
      throw Exception('Error al eliminar de SecureStorage ($key): $e');
    }
  }

  Future<void> _deleteAllSecureStorage() async {
    try {
      await _storage.deleteAll();
    } catch (e) {
      throw Exception('Error al eliminar todo de SecureStorage: $e');
    }
  }
}

