import 'dart:io';

import '../../../settings/app_config.dart';
import '../../../utils/dio_client.dart';

class MyProfileService {
  static final MyProfileService _instance = MyProfileService._internal();
  factory MyProfileService() => _instance;

  final AppConfig appConfig;
  final DioClient dioClient;
  MyProfileService._internal()
      : appConfig = AppConfig(),
        dioClient = DioClient();

  Future<Map<String, dynamic>> getMeProfile() async {
    String path = '/profile/me';
    final response = await dioClient.get(path);
    return response;
  }

  Future<List<Map<String, dynamic>>> getProfessions() async {
    String path = '/profile/professions/all';
    final response = await dioClient.getList(path);
    return response;
  }

  Future<List<Map<String, dynamic>>> getSentimentalSituations() async {
    String path = '/profile/sentimental-situations/all';
    final response = await dioClient.getList(path);
    return response;
  }

  Future<Map<String, dynamic>> updateSex(String sex) async {
    String path = '/profile/update-sex';
    final response = await dioClient.patchForm(path, {'sex': sex});
    return response;
  }

  Future<Map<String, dynamic>> updateBirthdate(String birthdate) async {
    String path = '/profile/update-birthdate';
    final response = await dioClient.patchForm(path, {'birthdate': birthdate});
    return response;
  }

  Future<Map<String, dynamic>> updateProfilePhoto(File file) async {
    String path = '/profile/update-profile-photo';
    final response = await dioClient.patchFileForm(path, {}, file);
    return response;
  }

  Future<Map<String, dynamic>> updateBio(String bio) async {
    String path = '/profile/update-bio';
    final response = await dioClient.patchForm(path, {'bio': bio});
    return response;
  }

  Future<Map<String, dynamic>> updateProfession(int professionId) async {
    String path = '/add-new-profession/$professionId';
    final response = await dioClient.patchPath(path);
    return response;
  }

  Future<Map<String, dynamic>> updateSentimentalSituation(
      int sentimentalSituationId) async {
    String path = '/update-sentimental-situation/$sentimentalSituationId';
    final response = await dioClient.patchPath(path);
    return response;
  }
}
