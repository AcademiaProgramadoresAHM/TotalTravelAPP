import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Components/Decodificador.dart';
import 'package:flutter_application_1/DefaultPackageScreens/DetailsPackage.dart';
import 'package:flutter_application_1/Models/RequestsViewModel.dart';
import 'package:flutter_application_1/feedback_screen.dart';
import 'package:flutter_application_1/utils/AppWidget.dart';
import 'package:nb_utils/nb_utils.dart';
import '../DefaultPackageScreens/ReservConfirm.dart';
import '../Home_Screen.dart';
import '../Models/ReservationViewModel.dart';
import '../Models/UsersViewModel.dart';
import 'package:flutter_application_1/utils/prueba2/T2Colors.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/hotel_booking/model/PlanModal.dart';

import '../Models/registerpaymentViewModel.dart';
import '../Screens/Personalizados.dart';
import '../SuccessOrErrorScreens/SuccesfullyReserDefaultPackage.dart';
import '../navigation_home_screen.dart';

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
  List<String> imageUrl;
  data.forEach((element) {
    imageUrl = element['image_URL'].split(',');
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
                        imageUrl[0].toString(),
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
                                  Flexible(
                                    flex: 4,
                                    child: Text(
                                      element['nombre'],
                                      style: TextStyle(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF090F13),
                                        fontSize: 26,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 2,
                                    child: Text(
                                      '\$' + element['precio'].toString(),
                                      style: TextStyle(
                                        fontFamily: 'Outfit',
                                        color: Color.fromRGBO(101, 45, 143, 1),
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                      ),
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

List<Padding> ListReservation(List<dynamic> data, BuildContext context, user) {
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
                                    'Reservacion del Cliente',
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
                                element['nombre_Hotel'],
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
                                  element['descripcionPaquete'],
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
                                        FindReservation(element['id'],
                                            userloggeddata, context);
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

Future<dynamic> GetListadoReservation(userloggeddata, context) async {
  List<dynamic> dataReservation;
  String url_list =
      "https://totaltravelapi.azurewebsites.net/API/Reservation/List";
  final headers = {
    "Content-type": "application/json",
    "Authorization": "bearer " + userloggeddata!.Token!
  };
  final response = await http.get(Uri.parse(url_list), headers: headers);
  if (response.statusCode == 200) {
    Map<String, dynamic> userMap = jsonDecode(response.body);
    var Json = Decodificador.fromJson(userMap);
    dataReservation = Json.data;
    var reservation = dataReservation
        .where((x) => x['id_Cliente'] == userloggeddata.ID)
        .toList();
  } else {
    print("Error " + response.statusCode.toString());
  }
}

Future<dynamic> FindReservation(idReservation, userloggeddata, context) async {
  List<dynamic> dataReservation;
  String url_list =
      "https://totaltravelapi.azurewebsites.net/API/Reservation/List";
  final headers = {
    "Content-type": "application/json",
    "Authorization": "bearer " + userloggeddata!.Token!
  };
  final response = await http.get(Uri.parse(url_list), headers: headers);
  if (response.statusCode == 200) {
    Map<String, dynamic> userMap = jsonDecode(response.body);
    var Json = Decodificador.fromJson(userMap);
    dataReservation = Json.data;
    var reservation =
        dataReservation.where((x) => x['id'] == idReservation).toList();

    // print(reservation);
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => ReservConfirm()));
  } else {
    print("Error " + response.statusCode.toString());
  }
}

int? reservID;

Future<void> PostReservertion(
    double? precio,
    int? HotID,
    ReservationViewmodel? reservacion,
    ModelDataRecordPayment payment,
    UserLoggedModel? userloggeddata,
    BuildContext context) async {
  final headers = {
    "Content-type": "application/json",
    "Authorization": "bearer " + userloggeddata!.Token!
  };
  final uri = Uri.parse(
      "https://totaltravelapi.azurewebsites.net/API/Reservation/Insert");

  final json = jsonEncode(reservacion);
  final response = await http.post(
    uri,
    headers: headers,
    body: json,
  );

  if (response.body != "") {
    print(response.body);
    Map<String, dynamic> userMap = jsonDecode(response.body);
    var dataInsert = Decodificador.fromJson(userMap);
    if (dataInsert.data != 0) {
      RequestStatus status = RequestStatus.fromJson(dataInsert.data);
      if (status.CodeStatus! >= 0) {
        reservID = status.CodeStatus!.toInt();
        print(reservID);
        PostRecordPayment(reservID, payment.idpayment, payment.monto,
            payment.formatted, userloggeddata, context);
      }
    }
  }
}

int? res;

Future<void> PostRecordPayment(
    int? reservID,
    int? tipopagoID,
    double? monto,
    String? fechaPago,
    UserLoggedModel? userloggeddata,
    BuildContext context) async {
  RecordPaymentModel RegistroPago = new RecordPaymentModel();

  RegistroPago.resvId = reservID;
  RegistroPago.tiPaId = tipopagoID;
  RegistroPago.rePaMonto = monto;
  RegistroPago.rePaFechaPago = fechaPago;
  RegistroPago.rePaUsuarioCreacion = userloggeddata!.ID;

  final headers = {
    "Content-type": "application/json",
    "Authorization": "bearer " + userloggeddata.Token!
  };

  final uri = Uri.parse(
      "https://totaltravelapi.azurewebsites.net/API/RecordPayment/Insert");
  final json = jsonEncode(RegistroPago);

  final response = await http.post(
    uri,
    headers: headers,
    body: json,
  );
  if (response.body != "") {
    print(response.body);

    Map<String, dynamic> userMap = jsonDecode(response.body);
    var dataInsert = Decodificador.fromJson(userMap);
    if (dataInsert.data != 0) {
      RequestStatus status = RequestStatus.fromJson(dataInsert.data);
      if (status.CodeStatus! >= 0) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NavigationHomeScreen(
                SuccesReservDefaultPack(userloggeddata), userloggeddata),
          ),
        );
      }
    }
  }
}


//                                            /
//                         _,.------....___,.' ',.-.
//                      ,-'          _,.--"        |
//                    ,'         _.-'              .
//                   /   ,     ,'                   `
//                  .   /     /                     ``.
//                  |  |     .                       \.\
//        ____      |___._.  |       __               \ `.
//      .'    `---""       ``"-.--"'`  \               .  \
//     .  ,            __               `              |   .
//     `,'         ,-"'  .               \             |    L
//    ,'          '    _.'                -._          /    |
//   ,`-.    ,".   `--'                      >.      ,'     |
//  . .'\'   `-'       __    ,  ,-.         /  `.__.-      ,'
//  ||:, .           ,'  ;  /  / \ `        `.    .      .'/
//  j|:D  \          `--'  ' ,'_  . .         `.__, \   , /
// / L:_  |                 .  "' :_;                `.'.'
// .    ""'                  """""'                    V
//  `.                                 .    `.   _,..  `
//    `,_   .    .                _,-'/    .. `,'   __  `
//     ) \`._        ___....----"'  ,'   .'  \ |   '  \  .
//    /   `. "`-.--"'         _,' ,'     `---' |    `./  |
//   .   _  `""'--.._____..--"   ,             '         |
//   | ." `. `-.                /-.           /          ,
//   | `._.'    `,_            ;  /         ,'          .
//  .'          /| `-.        . ,'         ,           ,
//  '-.__ __ _,','    '`-..___;-...__   ,.'\ ____.___.'
//  `"^--'..'   '-`-^-'"--    `-^-'`.''"""""`.,^.`.--' R.P