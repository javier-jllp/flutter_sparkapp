import 'dart:ffi';
import 'dart:io';

import '../../../utils/dio_client.dart';
import '../../../services/sembast_service.dart';

class MyProfileService {
  static final MyProfileService _instance = MyProfileService._internal();
  factory MyProfileService() => _instance;


  final DioClient _dioClient;
  final SembastService _sembast;
  MyProfileService._internal()
      :  _dioClient = DioClient(),
        _sembast = SembastService();



  /*
    Inicio de metodos para manejar datos en Sembast
  */
  Future<Map<String, dynamic>> _getMyProfileSembast() async {
    Map<String, dynamic>? myProfile = await _sembast.getJson(_sembast.myProfileStore, 1);
    return myProfile ?? {};
  }

  Future<List<Map<String, dynamic>>> _getMyHobbiesSembast() async {
    List<Map<String, dynamic>> myHobbies = await _sembast.getAllJson(_sembast.myHobbiesStore);
    return myHobbies;
  }

  Future<List<Map<String, dynamic>>> _getHobbiesSembast() async {
    List<Map<String, dynamic>> hobbies = await _sembast.getAllJson(_sembast.hobbiesStore);
    return hobbies;
  }

  Future<List<Map<String, dynamic>>> _getSexesSembast() async {
    List<Map<String, dynamic>> sexes = await _sembast.getAllJson(_sembast.sexesStore);
    return sexes;
  }

  Future<List<Map<String, dynamic>>> _getSeeksSembast() async {
    List<Map<String, dynamic>> seeks = await _sembast.getAllJson(_sembast.seeksStore);
    return seeks;
  }

  Future<List<Map<String, dynamic>>> _getSmokingHabitsSembast() async {
    List<Map<String, dynamic>> smokingHabits = await _sembast.getAllJson(_sembast.smokingHabitsStore);
    return smokingHabits;
  }

  Future<List<Map<String, dynamic>>> _getDrinkingHabitsSembast() async {
    List<Map<String, dynamic>> drinkingHabits = await _sembast.getAllJson(_sembast.drinkingHabitsStore);
    return drinkingHabits;
  }

  Future<void> _createOrUpdateMyProfileSembast() async {
    // realizar la peticion al backend
    String path = '/profiles/me';
    final response = await _dioClient.get(path);
    // almacenar en sembast
    await _sembast.putJson(_sembast.myProfileStore, 1, response);
  }

  Future<void> _createOrUpdateMyHobbiesSembast() async {
    // realizar la peticion al backend
    String path = '/profiles/hobbies/me';
    final response = await _dioClient.getListJson(path);
    // almacenar en sembast
    await _sembast.putAllJsonList(_sembast.myHobbiesStore, response);
  }

  Future<void> _createOrUpdateSexesSembast() async {
    // realizar la peticion al backend
    String path = '/profiles/sexes/all';
    final response = await _dioClient.getListJson(path);
    // almacenar en sembast
    await _sembast.putAllJsonList(_sembast.sexesStore, response);
  }

  Future<void> _createOrUpdateSeeksSembast() async {
    // realizar la peticion al backend
    String path = '/profiles/seeks/all';
    final response = await _dioClient.getListJson(path);
    // almacenar en sembast
    await _sembast.putAllJsonList(_sembast.seeksStore, response);
  }

  Future<void> _createOrUpdateSmokingHabitsSembast() async {
    // realizar la peticion al backend
    String path = '/profiles/smoking-habits/all';
    final response = await _dioClient.getListJson(path);
    // almacenar en sembast
    await _sembast.putAllJsonList(_sembast.smokingHabitsStore, response);
  }

  Future<void> _createOrUpdateDrinkingHabitsSembast() async {
    // realizar la peticion al backend
    String path = '/profiles/drinking-habits/all';
    final response = await _dioClient.getListJson(path);
    // almacenar en sembast
    await _sembast.putAllJsonList(_sembast.drinkingHabitsStore, response);
  }
  /*
    Inicio de metodos para manejar datos en Sembast
  */



  // Metodos gets

  Future<Map<String, dynamic>> getMeProfile() async {
    Map<String, dynamic> myProfile = await _getMyProfileSembast();
    if (myProfile.isNotEmpty) return myProfile;

    // realizar la peticion al backend
    await _createOrUpdateMyProfileSembast();
    Map<String, dynamic> newSembastData = await _getMyProfileSembast();
    return newSembastData;
  }

  Future<Map<String, dynamic>> getMeProfileInfoAdditional() async {
    // realizar siempre la peticion al backend para este datos, ya que cambian con frecuencia 
    String path = '/profiles/me-info-additional';
    final response = await _dioClient.get(path);
    return response;
  }

  Future<List<Map<String, dynamic>>> getMyHobbies() async {
    List<Map<String, dynamic>> myHobbies = await _getMyHobbiesSembast();
    if (myHobbies.isNotEmpty) return myHobbies;

    // realizar la peticion al backend
    await _createOrUpdateMyHobbiesSembast();
    List<Map<String, dynamic>> newSembastData = await _getMyHobbiesSembast();
    return newSembastData;  
  }

  Future<List<Map<String, dynamic>>> getHobbies() async {
    List<Map<String, dynamic>> myHobbies = await _getHobbiesSembast();
    if (myHobbies.isNotEmpty) return myHobbies;

    // realizar la peticion al backend
    await _createOrUpdateMyHobbiesSembast();
    List<Map<String, dynamic>> newSembastData = await _getHobbiesSembast();
    return newSembastData;
  }

  Future<List<Map<String, dynamic>>> getSexes() async {
    List<Map<String, dynamic>> sexes = await _getSexesSembast();
    if (sexes.isNotEmpty) return sexes;

    // realizar la peticion al backend
    await _createOrUpdateSexesSembast();
    List<Map<String, dynamic>> newSembastData = await _getSexesSembast();
    return newSembastData;  
  }

  Future<List<Map<String, dynamic>>> getSeeks() async {
    List<Map<String, dynamic>> seeks = await _getSeeksSembast();
    if (seeks.isNotEmpty) return seeks;

    // realizar la peticion al backend
    await _createOrUpdateSeeksSembast();
    List<Map<String, dynamic>> newSembastData = await _getSeeksSembast();
    return newSembastData;
  }

  Future<List<Map<String, dynamic>>> getSmokingHabits() async {
    List<Map<String, dynamic>> smokingHabits = await _getSmokingHabitsSembast();
    if (smokingHabits.isNotEmpty) return smokingHabits;

    // realizar la peticion al backend
    await _createOrUpdateSmokingHabitsSembast();
    List<Map<String, dynamic>> newSembastData = await _getSmokingHabitsSembast();
    return newSembastData;
  }

  Future<List<Map<String, dynamic>>> getDrinkingHabits() async {
    List<Map<String, dynamic>> drinkingHabits = await _getDrinkingHabitsSembast();    
    if (drinkingHabits.isNotEmpty) return drinkingHabits;

    // realizar la peticion al backend
    await _createOrUpdateDrinkingHabitsSembast();
    List<Map<String, dynamic>> newSembastData = await _getDrinkingHabitsSembast();
    return newSembastData;
  }






  // Metodos para actualizar datos del perfil

  Future<Map<String, dynamic>> updateSex(int sexId) async {
    String path = '/profiles/update-sex';
    final response = await _dioClient.patchForm(path, {'sex_id': sexId});
    await _createOrUpdateMyProfileSembast();
    return response;
  }

  Future<Map<String, dynamic>> updateSexOrientation(int sexId) async {
    String path = '/profiles/update-sex_orientation';
    final response =
        await _dioClient.patchForm(path, {'sex_orientation_id': sexId});
    await _createOrUpdateMyProfileSembast();
    return response;
  }

  Future<Map<String, dynamic>> updateSeeks(int seeksId) async {
    String path = '/profiles/update-seeks';
    final response = await _dioClient.patchForm(path, {'seeks_id': seeksId});
    await _createOrUpdateMyProfileSembast();
    return response;
  }

  Future<Map<String, dynamic>> updateSmokingHabit(int smokingHabitId) async {
    String path = '/profiles/update-smoking_habit';
    final response =
        await _dioClient.patchForm(path, {'smoking_habit_id': smokingHabitId});
    await _createOrUpdateMyProfileSembast();
    return response;
  }

  Future<Map<String, dynamic>> updateDrinkingHabit(int drinkingHabitId) async {
    String path = '/profiles/update-drinking_habit';
    final response =
        await _dioClient.patchForm(path, {'drinking_habit_id': drinkingHabitId});
    await _createOrUpdateMyProfileSembast();
    return response;
  }

  Future<Map<String, dynamic>> updateLocation(
      Float latitude, Float longitude) async {
    String path = '/profiles/update-location';
    dynamic data = {'latitude': latitude, 'longitude': longitude};
    final response = await _dioClient.patchForm(path, data);
    await _createOrUpdateMyProfileSembast();
    return response;
  }

  Future<Map<String, dynamic>> updateBirthdate(String birthdate) async {
    String path = '/profiles/update-birthdate';
    final response = await _dioClient.patchForm(path, {'birthdate': birthdate});
    await _createOrUpdateMyProfileSembast();
    return response;
  }

  Future<Map<String, dynamic>> updateProfilePhoto(File file) async {
    String path = '/profiles/update-profile-photo';
    final response = await _dioClient.patchFileForm(path, {}, file);
    await _createOrUpdateMyProfileSembast();
    return response;
  }

  Future<Map<String, dynamic>> updateBio(String bio) async {
    String path = '/profiles/update-bio';
    final response = await _dioClient.patchForm(path, {'bio': bio});
    await _createOrUpdateMyProfileSembast();
    return response;
  }

  Future<Map<String, dynamic>> updateStature(int stature) async {
    String path = '/profiles/update-stature';
    final response = await _dioClient.patchForm(path, {'stature': stature});
    await _createOrUpdateMyProfileSembast();
    return response;
  }

  Future<Map<String, dynamic>> addNewHobby(int hobbyId) async {
    String path = '/profiles/add-new-hobby';
    dynamic data = {'hobby_id': hobbyId};
    final response = await _dioClient.postForm(path, data);
    await _createOrUpdateMyHobbiesSembast();
    return response;
  }

  Future<Map<String, dynamic>> removeHobby(int hobbyId) async {
    String path = '/profiles/remove-my-hobby/$hobbyId';
    dynamic data = {'hobby_id': hobbyId};
    final response = await _dioClient.postForm(path, data);
    await _createOrUpdateMyHobbiesSembast();
    return response;
  }




  // Metodos para actualizar datos de accounts como: full_name y phone_number
  Future<Map<String, dynamic>> updateFullName(String fullName) async {
    String path = '/accounts/update-full_name';
    final response = await _dioClient.patchForm(path, {'full_name': fullName});
    await _createOrUpdateMyProfileSembast();
    return response;
  }

  Future<Map<String, dynamic>> updatePhoneNumber(String phoneNumber) async {
    String path = '/accounts/update-phone_number';
    final response =
        await _dioClient.patchForm(path, {'phone_number': phoneNumber});
    await _createOrUpdateMyProfileSembast();
    return response;
  }

}
