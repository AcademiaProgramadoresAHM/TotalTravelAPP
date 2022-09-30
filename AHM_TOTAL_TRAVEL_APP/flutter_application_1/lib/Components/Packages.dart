import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Components/Decodificador.dart';
import 'package:flutter_application_1/utils/AppWidget.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/hotel_booking/model/PlanModal.dart';

//-------------LISTADO DE PAQUETES PREDETERMINADOS--------------

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

List<Padding> ListDefaultPackages(List<dynamic> data, BuildContext context) {
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
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              child: Image.network(
                'https://images.unsplash.com/photo-1601918774946-25832a4be0d6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YWlyYm5ifGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60',
                width: double.infinity,
                height: 190,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 8),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      element['nombre'],
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        color: Color(0xFF101213),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 8),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      element['hotel'],
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        color: Color(0xFF57636C),
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 0, 90, 8),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      element['descripcion_Paquete'],
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
            Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 24, 12),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(
                      Icons.star_rounded,
                      color: Color(0xFFFFA130),
                      size: 24,
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
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
                      padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
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
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(80, 0, 0, 0),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('Ver Detalles'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  });

  return list;
}

List<Container> LandScreenPackage(List<dynamic> data, BuildContext context) {
  List<Container> list = [];
  List<PlanModal> planList = [];
  final _controller = PageController();
  for (var i = 0; i <= 3; i++) {
    var element = data[i];
    planList.add(
      PlanModal(
        image: 'assets/images/Argentina.jpg',
        title: element['nombre'],
        subTitle: 'Disfruta de un experiencia inolvidable',
        price: '\$0',
        planPriceSubTitle: 'per user/month',
        optionList: [
          PlanModal(title: 'Viaja hazta con 3 personas mas'),
          PlanModal(title: 'Transporte hacia tu destino'),
          PlanModal(title: 'Hoteles 5 Estrellas'),
        ],
      ),
    );
  }
  return list;
}
