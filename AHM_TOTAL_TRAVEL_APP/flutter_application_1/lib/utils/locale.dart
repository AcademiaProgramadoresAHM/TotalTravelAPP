import 'dart:html';
import 'package:flutter_application_1/utils/prueba2/T2Strings.dart';
import 'package:get/get.dart';

class AppLocale extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'app_name': 'FVF Requests App',
          'lenguage': "en_US",
        },
        'es_ES': {
          'app_name': 'FVF Solicitudes App',
          'lenguage': "es_ES",
        }
      };
}
