import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Components/Decodificador.dart';
import '../Models/ReservationViewModel.dart';
import '../Models/UsersViewModel.dart';
import 'EditReservation.dart';

class PaqueteDetailConfirm extends StatefulWidget {
  final UserLoggedModel? userloggeddata;
  final List<dynamic> Reservacion;
  final ReservEdit? reservacionEditado;
  final List<dynamic> PaqueteDetalles;
  String? PaqueteDescrip;
  double Precio;

  PaqueteDetailConfirm(this.userloggeddata, this.reservacionEditado,
      this.PaqueteDetalles, this.Reservacion, this.PaqueteDescrip, this.Precio);
  @override
  State<PaqueteDetailConfirm> createState() => _PaqueteDetailConfirmState();
}

class _PaqueteDetailConfirmState extends State<PaqueteDetailConfirm> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String worldDuracion = "Días";
  Future<dynamic> GetListadoPackageshome() async {
    String url_list =
        "https://apitotaltravel.azurewebsites.net/API/DefaultPackages/List";
    final response = await http.get(Uri.parse(url_list));
    if (response.statusCode == 200) {
      Map<String, dynamic> userMap = jsonDecode(response.body);
      var user = Decodificador.fromJson(userMap);
      return user.data;
    } else {
      print("Error " + response.statusCode.toString());
    }
  }

  List<Padding> PackageDetails(List<dynamic> data, BuildContext context) {
    List<Padding> list = [];
    final _controller = PageController();
    List<String> imageUrl;
    data.forEach((element) {
      imageUrl = element['image_URL'].split(',');
      list.add(
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(18, 14, 18, 0),
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
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                      flex: 6,
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(18, 10, 0, 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 190,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              imageUrl[0].toString(),
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                  child: Flexible(
                    child: Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 12,
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(15, 0, 5, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          flex: 6,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                element['nombre'],
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 20,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(2, 12, 24, 12),
                                                child: Row(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 10, 0, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Flexible(
                                              child: new Text(
                                            element['descripcion_Paquete'],
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black),
                                          )),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 20, 0, 20),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Flexible(
                                            child: new Text('Duracion:',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black)),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    75, 0, 0, 0),
                                            child: Flexible(
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(20, 0, 0, 0),
                                                child: Text(
                                                    "${element['duracion_Paquete']} ${worldDuracion}",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.black)),
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
                                          Text('Costo:',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black)),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    120, 0, 0, 0),
                                            child: Text(
                                                element['precio'].toString() ??
                                                    '00.00',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black)),
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
                                            child: Text('Ciudad Ubicacion:',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black)),
                                          ),
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(10, 0, 0, 0),
                                              child: Text(element['ciudad'],
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black)),
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
                                            child: Text('Hotel de Hospedaje:',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black)),
                                          ),
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(10, 0, 0, 0),
                                              child: Text(element['hotel'],
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Flexible(
                                          child: Text('Restaurante Incluido:',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black)),
                                        ),
                                        Flexible(
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10, 0, 0, 0),
                                            child: Text(
                                                element['restaurante'] ??
                                                    'No Incluye Restaurentes',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromRGBO(101, 45, 143, 1)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        child: Text(
                          'Confirmar Cambio',
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
                                builder: (context) => EditReserv(
                                    widget.userloggeddata,
                                    widget.Reservacion,
                                    widget.reservacionEditado,
                                    widget.PaqueteDescrip,
                                    widget.Precio,
                                    element['id'])),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      widget.reservacionEditado!.paquId = element['id'];
      widget.PaqueteDescrip = element['descripcion_Paquete'];
      widget.reservacionEditado?.resvPrecio = element['precio'];
      widget.Precio = element['precio'];
    });

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(101, 45, 143, 1),
          title: Row(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Center(
                  child: Text(
                    'Detalles',
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
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SafeArea(
                child: GestureDetector(
                    onTap: () => FocusScope.of(context).unfocus(),
                    child: Column(
                      children: [
                        FutureBuilder<dynamic>(
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                  child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 350, 0, 0),
                                child: CircularProgressIndicator(
                                    color: Color.fromARGB(255, 101, 45, 144)),
                              ));
                            } else {
                              if (snapshot.hasData) {
                                return Wrap(
                                    spacing: 8,
                                    runSpacing: 4,
                                    alignment: WrapAlignment.start,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.start,
                                    direction: Axis.horizontal,
                                    runAlignment: WrapAlignment.start,
                                    verticalDirection: VerticalDirection.down,
                                    clipBehavior: Clip.none,
                                    children: PackageDetails(
                                        widget.PaqueteDetalles, context));
                              } else {
                                return Center(
                                    child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 350, 0, 0),
                                  child: CircularProgressIndicator(
                                      color: Color.fromARGB(255, 101, 45, 144)),
                                ));
                              }
                            }
                          },
                          future: GetListadoPackageshome(),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ));
  }
}
