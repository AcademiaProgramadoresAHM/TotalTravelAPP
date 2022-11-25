import 'dart:async';

import 'package:flutter/material.dart';
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
import 'package:universal_html/html.dart' as formdata;

Future<void> PostRegister(
    String DNI,
    String Nombre,
    String Apellido,
    String Email,
    String FechaNacimiento,
    String Telefono,
    String Sexo,
    String Password,
    String adressId,
    BuildContext context) async {
      
  /*UserRegisterModel registerData = new UserRegisterModel();
  registerData.Usua_DNI = DNI;
  registerData.Usua_Nombre = Nombre;
  registerData.Usua_Apellido = Apellido;
  registerData.Usua_Email = Email;
  registerData.Usua_FechaNaci = FechaNacimiento;
  registerData.Usua_Telefono = Telefono;
  registerData.Usua_Sexo = Sexo;
  registerData.Dire_ID = adressId;
  registerData.Usua_Password = Password;
  registerData.Role_ID = 2;
  registerData.Usua_UsuarioCreacion = 1;
  registerData.Usua_esAdmin = 0;
  registerData.File = "string";*/
  // ignore: unnecessary_new

  /*final data =  await new formdata.FormData();
  data.append("usua_DNI", DNI.toString());
  data.append("usua_Nombre", Nombre);
  data.append("usua_Apellido", Apellido);
  data.append("usua_FechaNaci", Email);
  data.append("usua_Telefono", FechaNacimiento);
  data.append("usua_Sexo", Sexo);
  data.append("usua_Email", Telefono);
  data.append("usua_Password", Password);
  data.append("dire_ID", adressId as String);
  data.append("usua_esAdmin", "0");
  data.append("role_ID", "2");
  data.append("part_ID", "0");
  data.append("usua_UsuarioCreacion", "1");
  data.append("file", null as String);*/

  
 /* var data = {  'usua_DNI' : DNI, 'usua_Nombre' : Nombre,
                'usua_Apellido' : Apellido, 'usua_FechaNaci' : FechaNacimiento,
                'usua_Telefono' : Telefono, 'usua_Sexo' : Sexo,
                'usua_Email' : Email, 'usua_Password' : Password, 
                'dire_ID' : adressId, 'usua_esAdmin' : "0",
                'role_ID' : "2", 'part_ID' : "0",
                'usua_UsuarioCreacion' : "1", 'file' : "null"};

             var parts = [];
  data.forEach((key, value) {
    parts.add('${Uri.encodeQueryComponent(key)}='
        '${Uri.encodeQueryComponent(value)}');
  });
  var formData = parts.join('&');*/

 /* final url = Uri.parse("https://apitotaltravel.azurewebsites.net/API/Users/Insert");
  final headers = {'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'};
  final response = await post(url, headers: headers, body: data);

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
            builder: (context) => Login(),
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
*/

  
 /* var data = {  'usua_DNI' : DNI, 'usua_Nombre' : Nombre,
                'usua_Apellido' : Apellido, 'usua_FechaNaci' : FechaNacimiento,
                'usua_Telefono' : Telefono, 'usua_Sexo' : Sexo,
                'usua_Email' : Email, 'usua_Password' : Password, 
                'dire_ID' : adressId, 'usua_esAdmin' : "0",
                'role_ID' : "2", 'part_ID' : "0",
                'usua_UsuarioCreacion' : "1", 'file' : "null"};
*/
final headers = {'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'};
final uri = Uri.parse("https://apitotaltravel.azurewebsites.net/API/Users/Insert");
var map = new Map<String, dynamic>();
map['usua_DNI'] = DNI;
map['usua_Nombre'] = Nombre;
map['usua_Apellido'] = Apellido;
map['usua_FechaNaci'] = FechaNacimiento;
map['usua_Telefono'] = Telefono;
map['usua_Sexo'] = Sexo;
map['usua_Email'] = Email;
map['usua_Password'] = Password;
map['dire_ID'] = adressId;
map['usua_esAdmin'] = "0";
map['role_ID'] = "2";
map['part_ID'] = "0";
map['usua_UsuarioCreacion'] = "1";
map['file'] = "string";

http.Response response = await http.post(
    uri,
    headers: headers,
    body: map,
);

if (response.body != " ") {
    Map<String, dynamic> userMap = jsonDecode(response.body);
    var data = DecoderAPI.fromJson(userMap);
    var status = RequestStatus.fromJson(data.data);
    if (status.CodeStatus! >= 0) {
      if (status.MessageStatus == "El DNI ya existe.") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: white,
          content: Text(
            textAlign: TextAlign.center,
            'El DNI ya existe.',
            style: TextStyle(color: redColor, fontSize: 16),
          ),
        ));
      } else if (status.MessageStatus == "El EMAIL ya existe.") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: white,
          content: Text(
            textAlign: TextAlign.center,
            'El correo electrónico ya existe.',
            style: TextStyle(color: redColor, fontSize: 16),
          ),
        ));
      } else if(status.CodeStatus! > 0) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(),
          ),
        );
      }else{
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: white,
          content: Text(
            textAlign: TextAlign.center,
             'Ha ocurrido un error.',
            style: TextStyle(color: redColor, fontSize: 16),
          ),
        ));
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
