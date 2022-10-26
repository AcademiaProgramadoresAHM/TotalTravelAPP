import 'dart:convert';

import 'package:flutter_application_1/Screens/Personalizados.dart';
import 'package:flutter_application_1/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Home_Screen.dart';
import 'package:flutter_application_1/home_screen.dart';
import 'package:http/http.dart' as http;

import '../Components/Decodificador.dart';
import '../Models/UsersViewModel.dart';
import '../navigation_home_screen.dart';

class Personali2Screen extends StatefulWidget {
  final UserLoggedModel? userloggeddata;

  const Personali2Screen(this.userloggeddata, {super.key});

  @override
  _Personali2ScreenState createState() => _Personali2ScreenState();
}

class _Personali2ScreenState extends State<Personali2Screen> {
  Future<dynamic> GetListReservation(userloggeddata) async {
    List<dynamic> dataHotels;
    String url_list =
        "https://totaltravelapi.azurewebsites.net/API/Reservation/List";
    final headers = {
      "Content-type": "application/json",
      "Authorization": "bearer " + widget.userloggeddata!.Token!
    };
    final response = await http.get(Uri.parse(url_list), headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> userMap = jsonDecode(response.body);
      var Json = Decodificador.fromJson(userMap);
      dataHotels = Json.data;
      var Hotel = dataHotels
          .where((x) => x['id_Cliente'] == userloggeddata.ID)
          .toList();

      return Hotel;
    } else {
      print("Error " + response.statusCode.toString());
    }
  }

  List<Padding> ListDefaultReservation(
      List<dynamic> data, BuildContext context) {
    List<Padding> list = [];
    final _controller = PageController();

    data.forEach((element) {
      list.add(Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 4),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Color.fromARGB(255, 255, 255, 255),
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
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
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
                                      element['numeroPersonas'].toString() +
                                          'Personas',
                                      style: TextStyle(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF090F13),
                                        fontSize: 25,
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
                                  element['descripcionPaquete'],
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    color: Color.fromRGBO(101, 45, 143, 1),
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  element['fecha_Entrada'],
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    color: Color.fromRGBO(101, 45, 143, 1),
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  element['fecha_Salida'],
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    color: Color.fromRGBO(101, 45, 143, 1),
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  element['nombre_Hotel'],
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    color: Color.fromRGBO(101, 45, 143, 1),
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  element['nombre'],
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    color: Color.fromRGBO(101, 45, 143, 1),
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  element['apellido'],
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    color: Color.fromRGBO(101, 45, 143, 1),
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 4, 0, 0),
                                  child: Text(
                                    element['email'],
                                    style: TextStyle(
                                      fontFamily: 'Outfit',
                                      color: Color(0xFF7C8791),
                                      fontSize: 25,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 4, 0, 0),
                                  child: Text(
                                    element['telefono'],
                                    style: TextStyle(
                                      fontFamily: 'Outfit',
                                      color: Color(0xFF7C8791),
                                      fontSize: 25,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 8, 0, 0),
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
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Personali2Screen(widget
                                                          .userloggeddata)));
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter layout demo',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: TextButton(
            style: TextButton.styleFrom(
              primary: Color.fromARGB(255, 255, 255, 255),
            ),
            onPressed: () {
              /*Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PersonaliScreen(widget.userloggeddata)),
                  );*/
            },
            child: Icon(Icons.arrow_back_ios),
          ),
          title: Text('   Detalles de la Reservacion'),
          backgroundColor: Color.fromRGBO(101, 45, 143, 1),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(" \n \n "),
                    const ListTile(
                      leading: Icon(Icons.verified_user),
                      title: Text('Usuario'),
                      subtitle: Text(
                          'Cliente: jojo Alvaro Reyes \nReservación hecha el : 22/09/22 \n\n'),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(" \n \n"),
                    const ListTile(
                      leading: Icon(Icons.list),
                      title: Text('Detalles'),
                      subtitle: Text(
                          'Interes Turistico: Honduras \nHotel de Hospedaje: Pepito´s Intercontinentals \nHabitación: A84 \nActividades Recretivas: Nadar con delfines, Sala de Juegos, Viaje en Lancha, Senderismo \n\n'),
                    )
                  ],
                ),
              ),
            ),
            Container(
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(" \n \n "),
                    const ListTile(
                      leading: Icon(Icons.date_range),
                      title: Text('Fechas'),
                      subtitle: Text(
                          'Tiempo de Hospejade: 3 dias, 2 noches \nFecha de Ida: 23/09/22 \nFecha de Regreso: 26/09/22 \n\n'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(" \n \n "),
                    const ListTile(
                      leading: Icon(Icons.info),
                      title: Text('** Información Adicional **'),
                      subtitle: Text(
                          ' Cualquier tipo de cambio, observación o error nos puedes contactar al número telefónico: +504 97979797 o al correo electronico: viajes123@gmail.com  \n\n'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
