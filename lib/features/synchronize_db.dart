import '../services/sembast_service.dart';
import '../utils/dio_client.dart';

class SynchronizeImmutableTables {
  static final SynchronizeImmutableTables _instance = SynchronizeImmutableTables._internal();
  factory SynchronizeImmutableTables() => _instance;
  SynchronizeImmutableTables._internal();

  final SembastService _sembast = SembastService();
  final DioClient _dioClient = DioClient();

  Future<void> synchronizeTablesDb() async {
    // Metodo para sincronizar las tablas inmutables
    final stores = [
      {'storeName': _sembast.hobbiesStore, 'endpointApi': '/profiles/hobbies/all'},
      {'storeName': _sembast.sexesStore, 'endpointApi': '/profiles/sexes/all'},
      {'storeName': _sembast.seeksStore, 'endpointApi': '/profiles/seeks/all'},
      {'storeName': _sembast.smokingHabitsStore, 'endpointApi': '/profiles/smoking-habits/all'},
      {'storeName': _sembast.drinkingHabitsStore, 'endpointApi': '/profiles/drinking-habits/all'},
      {'storeName': _sembast.categoriesStore, 'endpointApi': '/categories'},
    ];

    await Future.wait(stores.map((storeData) async {
      final storeName = storeData['storeName'] as String;
      final endpointApi = storeData['endpointApi'] as String;
      try {
        // Verificar si hay datos en la base de datos
        final hasData = await _sembast.hasAnyData(storeName);
        if (!hasData) {
          // Si no hay datos, obtener los datos de la API
          final response = await _dioClient.getListJson(endpointApi);
          await _sembast.putAllJsonList(storeName, response);
        }
      } catch (e) {
        throw Exception('Error al sincronizar la base de datos: $e');
      }
    }));
  }
}
