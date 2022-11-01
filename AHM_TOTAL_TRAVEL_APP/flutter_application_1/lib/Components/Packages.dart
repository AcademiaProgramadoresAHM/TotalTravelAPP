import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Components/Decodificador.dart';
import 'package:flutter_application_1/DefaultPackageScreens/DetailsPackage.dart';
import 'package:flutter_application_1/Models/RequestsViewModel.dart';
import 'package:flutter_application_1/feedback_screen.dart';
import 'package:flutter_application_1/utils/AppWidget.dart';
import 'package:nb_utils/nb_utils.dart';
import '../Models/UsersViewModel.dart';
import 'package:flutter_application_1/utils/prueba2/T2Colors.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/hotel_booking/model/PlanModal.dart';

import '../Screens/Personalizados.dart';

//-------------LISTADO DE PAQUETES PREDETERMINADOS--------------

UserLoggedModel? userloggeddata;

Future<dynamic> GetListadoPackages() async {
  String url_list =
      "https://totaltravelapi.azurewebsites.net/API/DefaultPackages/List";
  final response = await http.get(Uri.parse(url_list));
  if (response.statusCode == 200) {
    Map<String, dynamic> userMap = jsonDecode(response.body);
    var user = Decodificador.fromJson(userMap);
    return user.data;
  } else {
    print("Error " + response.statusCode.toString());
  }
}

Future<dynamic> FindPackage(
    idPackage, userloggeddata, BuildContext context) async {
  List<dynamic> datapackage;
  String url_list =
      "https://totaltravelapi.azurewebsites.net/API/DefaultPackages/List";
  final headers = {
    "Content-type": "application/json",
    "Authorization": "bearer " + userloggeddata!.Token!
  };
  final response = await http.get(Uri.parse(url_list), headers: headers);
  if (response.statusCode == 200) {
    Map<String, dynamic> userMap = jsonDecode(response.body);
    var Json = Decodificador.fromJson(userMap);
    datapackage = Json.data;
    var package = datapackage.where((x) => x['id'] == idPackage).toList();

    print(package);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DetailPackageScreen(userloggeddata, package)),
    );
  } else {
    print("Error " + response.statusCode.toString());
  }
}

List<Padding> ListDefaultPackages(
    List<dynamic> data, BuildContext context, user) {
  List<Padding> list = [];
  final _controller = PageController();

  data.forEach((element) {
    list.add(Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 4),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              color: Color(0x32000000),
              offset: Offset(0, 2),
            )
          ],
        ),
        child: Column(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        'https://picsum.photos/seed/898/600',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 10, 16, 12),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: 4,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(101, 45, 143, 1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    element['nombre'],
                                    style: TextStyle(
                                      fontFamily: 'Outfit',
                                      color: Color(0xFF090F13),
                                      fontSize: 26,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    '\$' + element['precio'].toString(),
                                    style: TextStyle(
                                      fontFamily: 'Outfit',
                                      color: Color.fromRGBO(101, 45, 143, 1),
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                element['hotel'],
                                style: TextStyle(
                                  fontFamily: 'Outfit',
                                  color: Color.fromRGBO(101, 45, 143, 1),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                child: Text(
                                  element['descripcion_Paquete'],
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    color: Color(0xFF7C8791),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          2, 12, 24, 12),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Icon(
                                            Icons.star_rounded,
                                            color: Color(0xFFFFA130),
                                            size: 24,
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    4, 0, 0, 0),
                                            child: Text(
                                              '4/5',
                                              style: TextStyle(
                                                fontFamily: 'Outfit',
                                                color: Color(0xFF101213),
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    8, 0, 0, 0),
                                            child: Text(
                                              'Rating',
                                              style: TextStyle(
                                                fontFamily: 'Outfit',
                                                color: Color(0xFF57636C),
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Color.fromRGBO(
                                                    101, 45, 143, 1)),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        'Ver Detalles',
                                        style: TextStyle(
                                          fontFamily: 'Outfit',
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      onPressed: () {
                                        FindPackage(
                                            element['id'], user, context);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  });

  return list;
}

Future<void> PostReservertion(
    int? UsuaID,
    String PaquID,
    bool Personalizado,
    int CantidadPagos,
    int NumPersonas,
    bool ConfrimPago,
    bool ConfirmHotel,
    bool ConfirmRestaurant,
    bool ConfirmTrans,
    int Precio,
    BuildContext context) async {
  final headers = {
    'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
  };
  final uri = Uri.parse("https://totaltravel.somee.com/API/Reservation/Insert");
  var map = new Map<String, dynamic>();
  map['usua_ID'] = UsuaID;
  map['paqu_ID'] = PaquID;
  map['resv_esPersonalizado'] = Personalizado;
  map['resv_CantidadPagos'] = CantidadPagos;
  map['resv_NumeroPersonas'] = NumPersonas;
  map['resv_ConfirmacionPago'] = ConfrimPago;
  map['resv_ConfirmacionHotel'] = ConfirmHotel;
  map['resv_ConfirmacionRestaurante'] = ConfirmRestaurant;
  map['resv_ConfirmacionTrans'] = ConfirmTrans;
  map['resv_Precio'] = Precio;

  http.Response response = await http.post(
    uri,
    headers: headers,
    body: map,
  );

  if (response.body != " ") {
    Map<String, dynamic> userMap = jsonDecode(response.body);
    var dataInsert = Decodificador.fromJson(userMap);
    var status = RequestStatus.fromJson(dataInsert.data);
    if (status.CodeStatus! >= 0) {
      if (status.CodeStatus == 0) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: white,
          content: Text(
            textAlign: TextAlign.center,
            'La Reservacion ya fue Realizada',
            style: TextStyle(color: redColor, fontSize: 16),
          ),
        ));
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PersonaliScreen(userloggeddata),
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
