import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/services/Device_installation_service.dart';
import 'package:flutter_application_1/models/Device_installation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class NotificationRegistrationService {
  static const notificationRegistration = const MethodChannel(
      'com.totaltravel.flutter_application_1/notificationregistration');

  static const String refreshRegistrationChannelMethod = "refreshRegistration";
  static const String installationsEndpoint = "api/notifications/installations";
  static const String cachedDeviceTokenKey = "cached_device_token";
  static const String cachedTagsKey = "cached_tags";

  final deviceInstallationService = DeviceInstallationService();
  final secureStorage = FlutterSecureStorage();

  String baseApiUrl;
  //String apikey;

  NotificationRegistrationService(this.baseApiUrl) {
    notificationRegistration
        .setMethodCallHandler(handleNotificationRegistrationCall);
  }

  String get installationsUrl => "$baseApiUrl$installationsEndpoint";

  Future<void> deregisterDevice() async {
    final cachedToken = await secureStorage.read(key: cachedDeviceTokenKey);
    final serializedTags = await secureStorage.read(key: cachedTagsKey);

    if (cachedToken == null || serializedTags == null) {
      return;
    }

    var deviceId = await deviceInstallationService.getDeviceId();

    if (deviceId.isEmpty) {
      throw "Unable to resolve an ID for the device.";
    }

    var response = await http.delete(Uri.parse("$installationsUrl/$deviceId"));

    if (response.statusCode != 200) {
      throw "Deregister request failed: ${response.reasonPhrase}";
    }

    await secureStorage.delete(key: cachedDeviceTokenKey);
    await secureStorage.delete(key: cachedTagsKey);
  }

  Future<void> registerDevice(List<String> tags) async {
    try {
      final deviceId = await deviceInstallationService.getDeviceId();
      final platform = await deviceInstallationService.getDevicePlatform();
      final token = await deviceInstallationService.getDeviceToken();

      final deviceInstallation =
          DeviceInstallation(deviceId, platform, token, tags);

      final response = await http.put(Uri.parse(installationsUrl),
          body: jsonEncode(deviceInstallation),
          headers: {"Content-Type": "application/json"});

      if (response.statusCode != 200) {
        throw "Register request failed: ${response.reasonPhrase}";
      }

      final serializedTags = jsonEncode(tags);

      await secureStorage.write(key: cachedDeviceTokenKey, value: token);
      await secureStorage.write(key: cachedTagsKey, value: serializedTags);
    } on PlatformException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw "Unable to register device: $e";
    }
  }

  Future<void> refreshRegistration() async {
    final currentToken = await deviceInstallationService.getDeviceToken();
    final cachedToken = await secureStorage.read(key: cachedDeviceTokenKey);
    final serializedTags = await secureStorage.read(key: cachedTagsKey);

    if (currentToken == null ||
        cachedToken == null ||
        serializedTags == null ||
        currentToken == cachedToken) {
      return;
    }

    final tags = jsonDecode(serializedTags);

    return registerDevice(tags);
  }

  Future<void> handleNotificationRegistrationCall(MethodCall call) async {
    switch (call.method) {
      case refreshRegistrationChannelMethod:
        return refreshRegistration();
      default:
        throw MissingPluginException();
        break;
    }
  }
}
