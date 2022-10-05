import 'package:flutter/material.dart';
import 'package:flutter_application_1/ComponentsLogin/Decoder.dart';
import 'package:flutter_application_1/Screens/crearPaquete.dart';
import 'package:flutter_application_1/home_screen.dart';
import 'package:flutter_application_1/Screens/Login.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_application_1/Models/UsersViewModel.dart';
import 'package:flutter_application_1/navigation_home_screen.dart';
import 'package:nb_utils/nb_utils.dart';

Future<void> PostLogin(
    String email, String password, BuildContext context) async {
  UserLoginModel loginData = new UserLoginModel();
  loginData.Email = email;
  loginData.Password = password;

  final url = Uri.parse("https://totaltravel.somee.com/API/Login");
  final headers = {"Content-type": "application/json", "Accept": "text/plain"};
  final json = jsonEncode(loginData);
  final response = await post(url, headers: headers, body: json);

  if (response.body != " ") {
    Map<String, dynamic> userMap = jsonDecode(response.body);
    var data = DecoderAPI.fromJson(userMap);

    if (data.data != null) {
      var userLogin = UserLoggedModel.fromJson(data.data);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NavigationHomeScreen(userLogin),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: white,
        content: Text(
          textAlign: TextAlign.center,
          'La contraseña o usuario son incorrectos.',
          style: TextStyle(color: redColor, fontSize: 16),
        ),
      ));
    }
  }
}
