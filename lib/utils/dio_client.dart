import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:uuid/uuid.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../settings/app_config.dart';
import '../features/accounts/utils/google_auth.dart';

//******************************************************************************************************* */

class DioClient {
  // Singleton para garantizar que solo haya una unica instancia
  static final DioClient _instance = DioClient._internal();
  factory DioClient() => _instance;
  final AppConfig _appConfig;
  // Instancia de Dio para realizar las solicitudes con interceptores
  late Dio _dioInterceptor;
  // Instancia de Dio principal para realizar las solicitudes
  late Dio _dio;

  DioClient._internal()
      : _appConfig = AppConfig(),
        _dioInterceptor = Dio(),
        _dio = Dio() {
    _dioInterceptor.options.baseUrl = _appConfig.apiDomain;
    _dioInterceptor.options.headers['Content-Type'] = 'application/json';
    _dio.options.baseUrl = _appConfig.apiDomain;
    _dio.options.headers['Content-Type'] = 'application/json';
    // para AuthenticationService es necesario enviar _dioInterceptor, esto es para evitar conflictos
    // ya que _dio es la instancia de Dio principal
    _dio.interceptors.add(MyInterceptor(_appConfig,
        AuthenticationService(dio: _dioInterceptor, appConfig: _appConfig)));
  }

  Future<Map<String, dynamic>> get(String path) async {
    try {
      final String? accessToken = await _appConfig.accessToken;
      final Response<dynamic> response = await _dio.get<dynamic>(
        path,
        options: Options(
          headers: <String, dynamic>{
            if (accessToken != null) 'Authorization': 'Bearer $accessToken',
          },
        ),
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw 'Error al realizar la solicitud: ${e.message}';
    }
  }

  Future<List<Map<String, dynamic>>> getListJson(String path) async {
    try {
      final String? accessToken = await _appConfig.accessToken;
      final Response<dynamic> response = await _dio.get<dynamic>(
        path,
        options: Options(
          headers: <String, dynamic>{
            if (accessToken != null) 'Authorization': 'Bearer $accessToken',
          },
        ),
      );
      return (response.data as List)
          .map((e) => e as Map<String, dynamic>)
          .toList();
    } on DioException catch (e) {
      throw 'Error al realizar la solicitud: ${e.message}';
    }
  }

  Future<Map<String, dynamic>> postJson(
      String path, Map<String, dynamic> data) async {
    try {
      final accessToken = await _appConfig.accessToken;
      final response = await _dio.post(
        path,
        data: data,
        options: Options(
          headers: {
            if (accessToken != null) 'Authorization': 'Bearer $accessToken',
          },
        ),
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw 'Error al realizar la solicitud: ${e.message}';
    }
  }

  Future<Map<String, dynamic>> postForm(
      String path, Map<String, String> data) async {
    try {
      final accessToken = await _appConfig.accessToken;
      final formData = FormData.fromMap(data);
      final response = await _dio.post(
        path,
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            if (accessToken != null) 'Authorization': 'Bearer $accessToken',
          },
        ),
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw 'Error al realizar la solicitud: ${e.message}';
    }
  }

  Future<Map<String, dynamic>> postFileForm(
      String path, Map<String, String> data, File file) async {
    try {
      final accessToken = await _appConfig.accessToken;
      final formData = FormData.fromMap(data);

      final mimeType = lookupMimeType(file.path);
      if (mimeType == null) {
        throw Exception('No se pudo determinar el tipo MIME del archivo.');
      }
      final uuid = const Uuid().v4();
      formData.files.add(MapEntry(
          uuid,
          await MultipartFile.fromFile(file.path,
              contentType:
                  MediaType(mimeType.split('/')[0], mimeType.split('/')[1]))));
      final response = await _dio.post(
        path,
        data: formData,
        options: Options(
          headers: {
            if (accessToken != null) 'Authorization': 'Bearer $accessToken',
          },
        ),
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw 'Error al realizar la solicitud: ${e.message}';
    } catch (e) {
      throw Exception('Error al subir el archivo: $e');
    }
  }

  Future<Map<String, dynamic>> patchFileForm(
      String path, Map<String, String> data, File file) async {
    try {
      final accessToken = await _appConfig.accessToken;
      final formData = FormData.fromMap(data);

      final mimeType = lookupMimeType(file.path);
      if (mimeType == null) {
        throw Exception('No se pudo determinar el tipo MIME del archivo.');
      }
      final uuid = const Uuid().v4();
      formData.files.add(MapEntry(
          uuid,
          await MultipartFile.fromFile(file.path,
              contentType:
                  MediaType(mimeType.split('/')[0], mimeType.split('/')[1]))));
      final response = await _dio.patch(
        path,
        data: formData,
        options: Options(
          headers: {
            if (accessToken != null) 'Authorization': 'Bearer $accessToken',
          },
        ),
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw 'Error al realizar la solicitud: ${e.message}';
    } catch (e) {
      throw Exception('Error al subir el archivo: $e');
    }
  }

  Future<Map<String, dynamic>> putJson(
      String path, Map<String, dynamic> data) async {
    try {
      final accessToken = await _appConfig.accessToken;
      final response = await _dio.put(
        path,
        data: data,
        options: Options(
          headers: {
            if (accessToken != null) 'Authorization': 'Bearer $accessToken',
          },
        ),
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw 'Error al realizar la solicitud: ${e.message}';
    } catch (e) {
      throw 'Error al realizar la solicitud: $e';
    }
  }

  Future<Map<String, dynamic>> putForm(
      String path, Map<String, String> data) async {
    try {
      final accessToken = await _appConfig.accessToken;
      final formData = FormData.fromMap(data);
      final response = await _dio.put(
        path,
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            if (accessToken != null) 'Authorization': 'Bearer $accessToken',
          },
        ),
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw 'Error al realizar la solicitud: ${e.message}';
    } catch (e) {
      throw 'Error al realizar la solicitud: $e';
    }
  }

  Future<Map<String, dynamic>> patchJson(
      String path, Map<String, dynamic> data) async {
    try {
      final accessToken = await _appConfig.accessToken;
      final response = await _dio.patch(
        path,
        data: data,
        options: Options(
          headers: {
            if (accessToken != null) 'Authorization': 'Bearer $accessToken',
          },
        ),
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw 'Error al realizar la solicitud: ${e.message}';
    } catch (e) {
      throw 'Error al realizar la solicitud: $e';
    }
  }

  Future<Map<String, dynamic>> patchForm(
      String path, Map<String, dynamic> data) async {
    try {
      final accessToken = await _appConfig.accessToken;
      final formData = FormData.fromMap(data);
      final response = await _dio.patch(
        path,
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            if (accessToken != null) 'Authorization': 'Bearer $accessToken',
          },
        ),
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw 'Error al realizar la solicitud: ${e.message}';
    } catch (e) {
      throw 'Error al realizar la solicitud: $e';
    }
  }

  Future<Map<String, dynamic>> patchPath(String path) async {
    try {
      final accessToken = await _appConfig.accessToken;
      final response = await _dio.patch(
        path,
        options: Options(
          headers: {
            if (accessToken != null) 'Authorization': 'Bearer $accessToken',
          },
        ),
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw 'Error al realizar la solicitud: ${e.message}';
    } catch (e) {
      throw 'Error al realizar la solicitud: $e';
    }
  }

  Future<Map<String, dynamic>> delete(String path) async {
    try {
      final accessToken = await _appConfig.accessToken;
      final response = await _dio.delete(
        path,
        options: Options(
          headers: {
            if (accessToken != null) 'Authorization': 'Bearer $accessToken',
          },
        ),
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw 'Error al realizar la solicitud: ${e.message}'; // Cambiar a una excepcion personalizada
    } catch (e) {
      throw 'Error al realizar la solicitud: $e';
    }
  }
}

//******************************************************************************************************* */

class MyInterceptor extends Interceptor {
  final AppConfig _appConfig;
  final AuthenticationService _authService;
  MyInterceptor(this._appConfig, this._authService);
  // actualizar access_token si en caso el token ya expiro o faltanto 2 segundos para el expiracion
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      await _authService.refreshAccessToken();
      final String? accessToken = await _appConfig.accessToken;
      if (accessToken != null) {
        options.headers['Authorization'] = 'Bearer $accessToken';
      }
      return handler.next(options);
    } on DioException catch (e) {
      _authService._handleDioError(e);
      return handler.reject(e);
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      // Respuesta exitosa, retorna los datos
      handler.next(response);
    } else {
      handler.reject(DioException(
          // Lanza el error original
          requestOptions: response.requestOptions,
          response: response,
          error: response.data['detail'] ??
              'Error desconocido (${response.statusCode})'));
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    handler.reject(err); // Lanza el error original
  }
}

//******************************************************************************************************* */

class AuthenticationService {
  final Dio dio;
  final AppConfig appConfig;
  AuthenticationService({required this.dio, required this.appConfig});

  Future<void> refreshAccessToken() async {
    final String? expRefreshToken = await appConfig.expRefreshToken;
    final String? refreshToken = await appConfig.refreshToken;

    // Verificar si el refresh token ha expirado
    if (expRefreshToken != null && _isRefreshTokenExpired(expRefreshToken)) {
      await _logout(); // Cerrar sesión si el refresh token ha expirado
      return; // Salir de la función si se ha cerrado sesión
    } else if (expRefreshToken == null || expRefreshToken.isEmpty) {
      await _decodeExpirationRefreshtoken(refreshToken!);
    }

    final String? accessToken = await appConfig.accessToken;
    final String? expAccessToken = await appConfig.expAccessToken;

    // Verificar si el token expira en menos de 2 segundos o ya ha expirado
    if (expAccessToken != null && _isAccessTokenExpired(expAccessToken)) {
      try {
        const path = '/accounts/create_new_access_token';
        final formData =
            FormData.fromMap({'current_refresh_token': refreshToken});
        final response = await dio.post(
          path,
          data: formData,
          options: Options(
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
          ),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          final Map<String, dynamic> responseData = response.data;
          await appConfig.setStorageAccessToken(responseData['access_token']);
          await _decodeExpirationAccessToken(responseData['access_token']);
          return;
        } else {
          // Manejar errores de respuesta del servidor (código de estado diferente de 200/201)
          _handleError(response.statusCode, response.data);
        }
      } on DioException catch (e) {
        _handleDioError(e); // Manejar errores de red
      } catch (e) {
        // Manejar otros errores
        _handleError(null, e); // Manejar otros errores
      }
    }else if (expAccessToken == null || expAccessToken.isEmpty) {
      // guardar la fecha de expiracion si aun no existe el accessToken en flutter_secure_storage
      await _decodeExpirationAccessToken(accessToken!);
    }
  }

  bool _isAccessTokenExpired(String expAccessToken) {
    try {
      final expirationDate = DateTime.parse(expAccessToken);
      final now = DateTime.now();
      return expirationDate.isBefore(now.add(const Duration(seconds: 2))) ||
          expirationDate.isBefore(now);
    } catch (e) {
      // Manejar el error si expAccessToken no es una fecha válida
      return true; // Considerar que el token ha expirado en caso de error
    }
  }

  bool _isRefreshTokenExpired(String expRefreshToken) {
    try {
      final expirationDate = DateTime.parse(expRefreshToken);
      final now = DateTime.now();
      return expirationDate.isBefore(now);
    } catch (e) {
      // Manejar el error si expRefreshToken no es una fecha válida
      return true; // Considerar que el token ha expirado en caso de error
    }
  }

  Future<void> _logout() async {
    // Tu lógica para cerrar sesión
    final GoogleAuthSparkApp googleAuth = GoogleAuthSparkApp();
    await googleAuth.signOutWithGoogle();
    await appConfig
        .deleteStorageAll(); // Borra todos los datos del almacenamiento
  }

  void _handleDioError(DioException e) {
    // Manejo de errores específicos de Dio, por ejemplo, mostrar un mensaje al usuario
    throw Exception('Error de red al actualizar token: ${e.message}');
  }

  void _handleError(int? statusCode, dynamic error) {
    // Manejo de errores generales, por ejemplo, mostrar un mensaje al usuario
    // Decides qué hacer aquí: relanzar la excepción o llamar a _logout()
    throw Exception('Error al actualizar token: $error');
  }

  Future<void> _decodeExpirationAccessToken(String accessToken) async {
    // funcion para decodificar la fecha de expiracion de accesstoken
    // Guarda la fecha de expiración en el almacenamiento flutter_secure_storage
    try {
      DateTime expAccesstoken = JwtDecoder.getExpirationDate(accessToken);
      appConfig.setStorageExpAccessToken(expAccesstoken.toString()); // Guarda la fecha de expiración en el almacenamiento
    } catch (e) {
      throw Exception('Error al decodificar el token: $e');
    }
  }

  Future<void> _decodeExpirationRefreshtoken(String refreshToken) async {
    // funcion para decodificar la fecha de expiracion de refreshtoken
    // Guarda la fecha de expiración en el almacenamiento flutter_secure_storage
    try{
      DateTime expRefreshToken = JwtDecoder.getExpirationDate(refreshToken);
      appConfig.setStorageExpRefreshToken(expRefreshToken.toString());
    } catch (e) {
      throw Exception('Error al decodificar el token: $e');
    }
  }
}

