import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class GeolocatorService {
  Future<Position?> getCurrentLocation(
      {LocationAccuracy accuracy = LocationAccuracy.high}) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Verifica si el servicio de ubicación esta habilitado
     
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Si no está habilitado, solicitar al usuario que lo habilite
      return null;
    }
    // Verificar los permisos de la ubicación
    permission = await Geolocator.checkPermission();
    
    if (permission == LocationPermission.denied) {
      // Si los permisos de la ubicación fueron denegados, solicitar permisos
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Si los permisos fueron denegados, no se puede obtener la ubicación
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permisos denegados permanentemente, solicitar al usuario que los habilite en la configuración del dispositivo
      await openAppSettings();
      return null; // No se puede obtener la ubicación
    }

    if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
      // Si los permisos no son "whileInUse" o "always", no se puede obtener la ubicación. Bloquear el acceso a la ubicación
      return null;
    }

    try {
      // Obtener la ubicación actual con la precisión especificada
      final locationSettings = LocationSettings(
        accuracy: accuracy, // Aquí se configura la precisión
        distanceFilter: 100, // Opcional: Filtrar por distancia
        timeLimit: const Duration(seconds: 10), // Opcional: Límite de tiempo
      );
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: locationSettings,
      );
      return position;
    } catch (e) {
      throw 'Error al obtener la ubicación: $e';
    }
  }
}
