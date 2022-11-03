import 'package:flutter/services.dart';

class DeviceInstallationService {
  static const deviceInstallation = const MethodChannel(
      'com.totaltravel.flutter_application_1/deviceinstallation');
  static const String getDeviceIdChannelMethod = "getDeviceId";
  static const String getDeviceTokenChannelMethod = "getDeviceToken";
  static const String getDevicePlatformChannelMethod = "getDevicePlatform";

  Future getDeviceId() {
    return deviceInstallation.invokeMethod(getDeviceIdChannelMethod);
  }

  Future getDeviceToken() {
    return deviceInstallation.invokeMethod(getDeviceTokenChannelMethod);
  }

  Future getDevicePlatform() {
    return deviceInstallation.invokeMethod(getDevicePlatformChannelMethod);
  }
}
