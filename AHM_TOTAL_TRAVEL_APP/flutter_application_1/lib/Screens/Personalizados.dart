import 'dart:convert';
import 'dart:math';
//import 'dart:js';

import 'package:flutter_application_1/Models/TimelineViewModel.dart';
import 'package:flutter_application_1/Screens/Timeline.dart';
import 'package:flutter_application_1/Screens/transporte.dart';
import 'package:flutter_application_1/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/ReserDetalles.dart';
import 'package:flutter_application_1/introduction_animation/components/center_next_button.dart';
import '../Models/UsersViewModel.dart';

import '../Components/Decodificador.dart';
import '../Components/Reservation.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

class PersonaliScreen extends StatefulWidget {
  final UserLoggedModel? userloggeddata;

  const PersonaliScreen(this.userloggeddata, {super.key});

  @override
  _PersonaliScreenState createState() => _PersonaliScreenState();
}

class _PersonaliScreenState extends State<PersonaliScreen> {
  Future<dynamic> GetListReservation(userloggeddata) async {
    List<dynamic> dataReservation;
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
      dataReservation = Json.data;
      var Reservation = dataReservation
          .where((x) => x['id_Cliente'] == userloggeddata.ID)
          .toList();

      return Reservation;
    } else {
      print("Error " + response.statusCode.toString());
    }
  }

  Future<dynamic> FindReservation(idReservation, userloggeddata) async {
    List<dynamic> dataReservation;
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
      dataReservation = Json.data;
      var reservation =
          dataReservation.where((x) => x['id'] == idReservation).toList();


      TimelineViewModel TimeLineModel = new TimelineViewModel([],0,'','','',0,'','','',0,'','');
      var id_reservation;
      reservation.forEach((x) {
        id_reservation = x['id'];
      });
      String url_list =
          "https://totaltravelapi.azurewebsites.net/API/Reservation/Find/Timeline?id=" + id_reservation.toString();
      final headers = {
        "Content-type": "application/json",
        "Authorization": "bearer " + widget.userloggeddata!.Token!
      };
      final respon = await http.get(Uri.parse(url_list), headers: headers);
      print("Este es el response: " + respon.body);
      if(respon.statusCode == 200){
        Map<String, dynamic> userMap = jsonDecode(respon.body);
        var Json = Decodificador.fromJson(userMap);
        var data = Json.data;
        var actividades = data['actividades'];
        var hotel = data['hotel_Info'];
        var trasporte = data['transporte_Info'];
        var cliente = data['cliente_Info'];
        
        print("Hotel" + hotel.toString());
        print("trasporte" + trasporte.toString());
        print("cliente" + cliente.toString());

        var id, actividad, fecha, fullresponse;
        Actividades acti = new Actividades(0, '', '');
        var i = 0;
        actividades.forEach((x) {
          acti.id_actividad = x['id'];
          acti.nombre_actividad = x['actividad'];
          acti.fecha_Actividad = x['fecha'];
          TimeLineModel.actividades!.insert(i, acti);
          i++;
        });

        hotel.forEach((x){
          TimeLineModel.id_Hotel = x['iD_Hotel'];
          TimeLineModel.Hotel = x['hotel'];
          TimeLineModel.Fecha_Entrada = x['fecha_Entrada'];
          TimeLineModel.Fecha_Salida = x['fecha_Salida'];
        });

        trasporte.forEach((x){
          TimeLineModel.iD_Transporte = x['iD_Transporte'];
          TimeLineModel.Transporte = x['transporte'];
          var Hora_Salida = x['horaSalida'].toString();
          var Hora_Llegada = x['horaLlegada'].toString();
          TimeLineModel.Hora_Salida = Hora_Salida.substring(1,2) + ':' + Hora_Salida.substring(3,4);
          TimeLineModel.Hora_Llegada = Hora_Llegada.substring(1,2) + ':' + Hora_Llegada.substring(3,4);
        });

        cliente.forEach((x){
          TimeLineModel.iD_Cliente = x['iD_Usuario'];
          TimeLineModel.nombre_Cliente = x['nombre'];
          TimeLineModel.apellido_Cliente = x['apellido'];
        });


        print(TimeLineModel.toString());
      /*Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  Personali2Screen(widget.userloggeddata, reservation)));*/
      }


    } else {
      print("Error " + response.statusCode.toString());
    }
  }

  List<Padding> ListDefaultReservation(
      List<dynamic> data, BuildContext context) {
    List<Padding> list = [];
    final _controller = PageController();

    data.forEach((element) {
      var splitFecha = element['fecha_Entrada'].toString().split('T');

      var fechaentrada = splitFecha[0];
//////////////////////////////////////////////////////////////
      var splitFechaSalida = element['fecha_Salida'].toString().split('T');

      var fechasalida = splitFechaSalida[0];

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
                                EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 20),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Flexible(
                                        child: new Text('Paquete :',
                                            style: TextStyle(
                                              fontFamily: 'Outfit',
                                              fontSize: 25,
                                              color: Color.fromRGBO(
                                                  101, 45, 143, 1),
                                            )),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  70, 0, 0, 0),
                                          child: Text(
                                            element['descripcionPaquete'],
                                            style: TextStyle(
                                              fontFamily: 'Outfit',
                                              color: Color.fromRGBO(
                                                  101, 45, 143, 1),
                                              fontSize: 22,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 20),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Flexible(
                                        child: new Text('Precio :',
                                            style: TextStyle(
                                              fontFamily: 'Outfit',
                                              fontSize: 22,
                                              color:
                                                  Color.fromARGB(255, 3, 3, 3),
                                            )),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  100, 0, 0, 0),
                                          child: Text(
                                            'L.' + element['precio'].toString(),
                                            style: TextStyle(
                                              fontFamily: 'Outfit',
                                              color:
                                                  Color.fromARGB(255, 3, 3, 3),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 20),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Flexible(
                                        child: new Text('Fecha de Entrada :',
                                            style: TextStyle(
                                              fontFamily: 'Outfit',
                                              fontSize: 20,
                                              color:
                                                  Color.fromARGB(255, 3, 3, 3),
                                            )),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10, 0, 0, 0),
                                          child: Text(
                                            fechaentrada,
                                            style: TextStyle(
                                              fontFamily: 'Outfit',
                                              color:
                                                  Color.fromARGB(255, 3, 3, 3),
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 20),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Flexible(
                                        child: new Text('Fecha de salida :',
                                            style: TextStyle(
                                              fontFamily: 'Outfit',
                                              fontSize: 20,
                                              color:
                                                  Color.fromARGB(255, 3, 3, 3),
                                            )),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  26, 0, 0, 0),
                                          child: Text(
                                            fechasalida,
                                            style: TextStyle(
                                              fontFamily: 'Outfit',
                                              color:
                                                  Color.fromARGB(255, 3, 3, 3),
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
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
                                          FindReservation(element['id'],
                                              widget.userloggeddata);
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

  late bool _isLoading;
  @override
  void initState() {
    _isLoading = true;
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter layout demo',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(101, 45, 143, 1),
          title: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Text(
                  '           ',
                ),
              ),
              Expanded(
                flex: 5,
                child: Center(
                  child: Text(
                    'Reservaciones Hechas',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Image.asset(
                    'assets/images/logo-AHM-Fondo-Morao.png',
                    height: 50,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            FutureBuilder<dynamic>(
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      direction: Axis.horizontal,
                      runAlignment: WrapAlignment.start,
                      verticalDirection: VerticalDirection.down,
                      clipBehavior: Clip.none,
                      children: ListDefaultReservation(snapshot.data, context));
                } else {
                  return Center(
                      child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 350, 0, 0),
                    child: CircularProgressIndicator(
                        color: Color.fromARGB(255, 101, 45, 144)),
                  ));
                }
              },
              future: GetListReservation(widget.userloggeddata),
            ),
          ],
        )),
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
