import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/EmailsViewModel.dart';
import 'package:flutter_application_1/Models/RequestsViewModel.dart';
import 'package:flutter_application_1/Models/UsersViewModel.dart';
import 'package:flutter_application_1/Screens/Login.dart';
import 'package:flutter_application_1/Screens/changePassword.dart';
import 'package:flutter_application_1/Screens/codeVerification.dart';
import 'package:flutter_application_1/SuccessOrErrorScreens/SuccessfullyEmailContact.dart';
import 'package:flutter_application_1/createCustomPackage/customPackage_Start.dart';
import 'package:flutter_application_1/navigation_home_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

import 'package:nb_utils/nb_utils.dart';

import 'Decoder.dart';

late final UserLoggedModel? userloggeddata;

Future<void> PostEmailVerification(String email, BuildContext context) async {
  EmailVerificationViewModel loginData = new EmailVerificationViewModel();
  loginData.Email = email;

  final url =
      Uri.parse("https://totaltravel.somee.com/API/Login/EmailVerification");
  final headers = {"Content-type": "application/json", "Accept": "text/plain"};
  final json = jsonEncode(loginData);
  final response = await post(url, headers: headers, body: json);

  if (response.body != " ") {
    Map<String, dynamic> userMap = jsonDecode(response.body);
    var data = DecoderAPI.fromJson(userMap);
    var status = RequestStatus.fromJson(data.data);

    if (status.CodeStatus! >= 0) {
      int? id = status.CodeStatus;
      PostEmailSender(email, context, id);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: white,
        content: Text(
          textAlign: TextAlign.center,
          'El correo electrónico no existe.',
          style: TextStyle(color: redColor, fontSize: 16),
        ),
      ));
    }
  }
}

Future<void> PostEmailSender(
    String email, BuildContext context, int? id) async {
  EmailVerificationViewModel loginData = new EmailVerificationViewModel();
  loginData.Email = email;

  final url = Uri.parse("https://totaltravel.somee.com/API/Login/EmailSender");
  final headers = {"Content-type": "application/json", "Accept": "text/plain"};
  final json = jsonEncode(loginData);
  final response = await post(url, headers: headers, body: json);

  Map<String, dynamic> userMap = jsonDecode(response.body);
  var emaildata = DecoderAPI.fromJson(userMap);

  if (emaildata.data != null) {}
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => codeVerificationScreen(emaildata.data, id),
    ),
  );
}

Future<void> verificationCode(
    int usercode, int? code, BuildContext context, int? id) async {
  if (usercode == code) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => changePasswordScreen(id),
      ),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: white,
      content: Text(
        textAlign: TextAlign.center,
        'El código es incorrecto.',
        style: TextStyle(color: redColor, fontSize: 16),
      ),
    ));
  }
}

Future<void> changePassword(
    int? id, String password, BuildContext context) async {
  UserRegisterModel loginData = new UserRegisterModel();
  loginData.Usua_ID = id;
  loginData.Usua_Password = password;

  final url =
      Uri.parse("https://totaltravel.somee.com/API/Users/UpdatePassword");
  final headers = {"Content-type": "application/json", "Accept": "text/plain"};
  final json = jsonEncode(loginData);
  final response = await put(url, headers: headers, body: json);
  if (response.body != " ") {
    Map<String, dynamic> userMap = jsonDecode(response.body);
    var data = DecoderAPI.fromJson(userMap);
    var status = RequestStatus.fromJson(data.data);
    if (status.CodeStatus! >= 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Login(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: white,
        content: Text(
          textAlign: TextAlign.center,
          'Ha ocurrido un error.',
          style: TextStyle(color: redColor, fontSize: 16),
        ),
      ));
    }
  }
}

Future<void> PostEmailContact(
    String body, String? user, BuildContext context) async {
  EmailContactViewModel emailBody = new EmailContactViewModel();
  emailBody.BodyData = body;
  emailBody.User = user;

  final url = Uri.parse(
      "https://totaltravelapi.azurewebsites.net/API/Login/EmailContact");
  final headers = {"Content-type": "application/json", "Accept": "text/plain"};
  final json = jsonEncode(emailBody);
  final response = await post(url, headers: headers, body: json);

  Map<String, dynamic> userMap = jsonDecode(response.body);
  var emaildata = DecoderAPI.fromJson(userMap);

  if (emaildata.data != null) {}
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => SuccessEmailContact(userloggeddata),
    ),
  );
}
