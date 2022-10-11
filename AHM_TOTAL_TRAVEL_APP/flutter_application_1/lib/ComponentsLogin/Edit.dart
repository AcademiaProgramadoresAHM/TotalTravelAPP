import 'package:flutter/material.dart';
import 'package:flutter_application_1/Account_screen.dart';
import 'package:flutter_application_1/ComponentsLogin/Decoder.dart';
import 'package:flutter_application_1/Models/RequestsViewModel.dart';
import 'package:flutter_application_1/home_screen.dart';
import 'package:flutter_application_1/Screens/Login.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_application_1/Models/UsersViewModel.dart';
import 'package:nb_utils/nb_utils.dart';

UserLoggedModel? userloggeddata;

Future<void> EditRegister(
    String DNI,
    String Nombre,
    String Apellido,
    String Email,
    String FechaNacimiento,
    String Telefono,
    String Sexo,
    int adressId,
    BuildContext context) async {
  UserRegisterModel editData = new UserRegisterModel();
  editData.Usua_DNI = DNI;
  editData.Usua_Nombre = Nombre;
  editData.Usua_Apellido = Apellido;
  editData.Usua_Email = Email;
  editData.Usua_FechaNaci = FechaNacimiento;
  editData.Usua_Telefono = Telefono;
  editData.Usua_Sexo = Sexo;
  editData.Dire_ID = adressId;
  editData.Role_ID = 2;
  editData.Usua_UsuarioCreacion = 1;
  editData.Usua_esAdmin = 0;

  final url = Uri.parse(
      "https://totaltravelapi.azurewebsites.net/API/Users/Update?id=" +
          userloggeddata!.ID.toString());
  final headers = {"Content-type": "application/json", "Accept": "text/plain"};
  final json = jsonEncode(editData);
  final response = await post(url, headers: headers, body: json);

  if (response.body != " ") {
    Map<String, dynamic> userMap = jsonDecode(response.body);
    var data = DecoderAPI.fromJson(userMap);
    var status = RequestStatus.fromJson(data.data);
    if (status.CodeStatus! >= 0) {
      if (status.CodeStatus == 0) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: white,
          content: Text(
            textAlign: TextAlign.center,
            'El DNI ya está siendo utilizado.',
            style: TextStyle(color: redColor, fontSize: 16),
          ),
        ));
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AccountInfo(userloggeddata),
          ),
        );
      }
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
