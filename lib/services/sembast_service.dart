import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';

class SembastService {
  static final SembastService _instance = SembastService._internal();
  factory SembastService() => _instance;
  SembastService._internal();

  // Stores locales, que no requieren sincronizar
  final String themeStore = "theme_store";

  // stores o tablas de la base de datos de api
  final String myProfileStore = "my_profile_store";
  final String myHobbiesStore = "my_hobbies_store";
  final String profilesStore = "profiles_store";
  final String hobbiesStore = "hobbies_store";
  final String sexesStore = "sex_store";
  final String seeksStore = "seeks_store";
  final String smokingHabitsStore = "smoking_habits_store";
  final String drinkingHabitsStore = "drinking_habits_store";
  final String categoriesStore = "categories_store";
  final String videosStore = "videos_store";
  final String imagesStore = "images_store";

  //Instancia de la base de datos
  Database? _database;

  // Inicializar la base de datos
  Future<Database> _getDatabase() async {
    if (_database != null) {
      return _database!;
    }
    // Optener la ruta de la base de datos
    const String databaseName = "dbsparkapp.db";
    final appDocumentDir = await getApplicationDocumentsDirectory();
    final dbPath = '${appDocumentDir.path}/$databaseName';
    _database = await databaseFactoryIo.openDatabase(dbPath);
    return _database!;
  }

  // Obtiene un store de la base de datos
  Future<StoreRef<int, Map<String, dynamic>>> getStore(String storeName) async {
    try {
      await _getDatabase();
      return intMapStoreFactory.store(storeName);
    } catch (e) {
      throw Exception('Error al obtener el store: $e');
    }
  }

  //Almacenar un JSON en la base de datos
  Future<void> putJson(String storeName, int id, Map<String, dynamic> jsonData) async {
    try {
      final store = await getStore(storeName);
      
      //Asigna 'sembast_id' si no está definido, este sera util para manejar localmente 
      if (!jsonData.containsKey('sembast_id')) {
        jsonData['sembast_id'] = id;
      }
      final db = await _getDatabase();
      await store.record(jsonData['sembast_id']).put(db, jsonData);
    } catch (e) {
      throw Exception('Error al almacenar el JSON: $e');
    }
  }

  //Almacenar varios JSON en la base de datos a partir de una lista de JSON
  Future<void> putAllJsonList(
      String storeName, List<Map<String, dynamic>> jsonList) async {
    try {
      final store = await getStore(storeName);
      
      final db = await _getDatabase();
      await db.transaction((txn) async {
        for (var json in jsonList) {
          if (!json.containsKey('id')) {
            throw Exception('El JSON debe contener un campo "id"');
          }
          await store.record(json['id']).put(txn, json);
        }
      });
    } catch (e) {
      throw Exception('Error al almacenar la lista de JSON: $e');
    }
  }

  //Obtener un JSON de la base de datos
  Future<Map<String, dynamic>?> getJson(String storeName, int key) async {
    try {
      final store = await getStore(storeName);
      final record = await store.record(key).get(await _getDatabase());
      return record;
    } catch (e) {
      throw Exception('Error al obtener el JSON: $e');
    }
  }

  //Obtener todos los JSON de la base de datos
  Future<List<Map<String, dynamic>>> getAllJson(String storeName) async {
    try {
      final store = await getStore(storeName);
      final recordSnapshot = await store.find(await _getDatabase());
      return recordSnapshot.map((snapshot) => snapshot.value).toList();
    } catch (e) {
      throw Exception('Error al obtener todos los JSON: $e');
    }
  }

  //Eliminar un JSON de la base de datos
  Future<void> deleteJson(String storeName, int key) async {
    try {
      final store = await getStore(storeName);
      await store.record(key).delete(await _getDatabase());
    } catch (e) {
      throw Exception('Error al eliminar el JSON: $e');
    }
  }

  //Eliminar todos los JSON de la base de datos
  Future<void> deleteAllJson(String storeName) async {
    try {
      final store = await getStore(storeName);
      await store.delete(await _getDatabase());
    } catch (e) {
      throw Exception('Error al eliminar todos los JSON: $e');
    }
  }

  // Verificar si un store tiene algun dato
  Future<bool> hasAnyData(String storeName) async {
    final store = await getStore(storeName);
    final count = await store.count(await _getDatabase());
    return count > 0;
  }

  //Cerrar la base de datos
  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}
