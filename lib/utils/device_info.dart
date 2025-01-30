import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

// Funcion para extraer informacion del dispositivo
Future<ReturnDeviceInfo> getDeviceInfo() async {
  if (Platform.isAndroid) {
    DeviceInfoPlugin diveceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await diveceInfo.androidInfo;

    return ReturnDeviceInfo(
        platform: 'ANDROID',
        version: androidInfo.version.release,
        brand: androidInfo.brand,
        model: androidInfo.model);
  } 
  if (Platform.isIOS) {
    DeviceInfoPlugin diveceInfo = DeviceInfoPlugin();
    IosDeviceInfo iosInfo = await diveceInfo.iosInfo;
    return ReturnDeviceInfo(
        platform: 'IOS', version: iosInfo.systemVersion, brand: iosInfo.name, model: iosInfo.model);
  }

  return ReturnDeviceInfo( platform: '', version: '', brand: '', model: '');
}

class ReturnDeviceInfo {
  final String platform;
  final String version;
  final String brand;
  final String model;

  ReturnDeviceInfo(
      {required this.platform, required this.version, required this.brand, required this.model});
}
