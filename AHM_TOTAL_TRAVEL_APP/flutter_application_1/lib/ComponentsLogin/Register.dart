import 'package:flutter/material.dart';
import 'package:flutter_application_1/ComponentsLogin/Decoder.dart';
import 'package:flutter_application_1/home_screen.dart';
import 'package:flutter_application_1/Screens/Login.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_application_1/Models/UsersViewModel.dart';

Future<void> PostRegister(String DNI, 
                          String Nombre,
                          String Apellido,
                          String Email,
                          String FechaNacimiento,
                          String Telefono,
                          String Sexo,
                          String Password, 
                          int adressId,
                          BuildContext context) async {

 UserRegisterModel registerData = new UserRegisterModel();
  registerData.Usua_DNI = DNI;
  registerData.Usua_Nombre = Nombre;
  registerData.Usua_Apellido = Apellido;
  registerData.Usua_Email = Email;
  registerData.Usua_FechaNaci = FechaNacimiento;
  registerData.Usua_Telefono = Telefono;
  registerData.Usua_Sexo = Sexo;
  registerData.Dire_ID = adressId;
  registerData.Usua_Password = Password;

  final url = Uri.parse("https://totaltravel.somee.com/API/Users/Insert");
  final headers = {"Content-type": "application/json", "Accept": "text/plain"};
  final json = jsonEncode(registerData);
  final response = await post(url, headers: headers, body: json);

  Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Login(),
        ),
      );

}