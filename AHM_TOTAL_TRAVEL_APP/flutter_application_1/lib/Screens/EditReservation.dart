import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Account_screen.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../Components/Decodificador.dart';
import '../EditarReservScreen/HotelList.dart';
import '../Models/CitiesViewModel.dart';
import '../Models/ReservationViewModel.dart';
import '../Models/UsersViewModel.dart';
import 'package:http/http.dart' as http;

import 'PaquetesEditresevr.dart';

class EditReserv extends StatefulWidget {
  final UserLoggedModel? userloggeddata;
  final List<dynamic> Reservacion;
  final ReservEdit? reservacionEditado;
  List<dynamic> Actividadespaquete;
  String? PaqueteDescrip;
  double Precio;
  int idpaquete;
  String HotelNombre;

  EditReserv(
      this.userloggeddata,
      this.Reservacion,
      this.reservacionEditado,
      this.PaqueteDescrip,
      this.Precio,
      this.idpaquete,
      this.HotelNombre,
      this.Actividadespaquete);
  @override
  State<EditReserv> createState() => _EditReservState();
}

class _EditReservState extends State<EditReserv> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String? Precio;
  String HotelNombre = "";
  void SetPrice(PayNumber) {
    setState(() {
      Precio = PayNumber;
    });
  }

  Future<dynamic> GetReservation() async {
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

  Future<dynamic> FindPackages(idpackage, userloggeddata) async {
    List<dynamic> datapackage;

    String url_list =
        "https://apitotaltravel.azurewebsites.net/API/DefaultPackages/List";
    final response = await http.get(Uri.parse(url_list));
    final headers = {
      "Content-type": "application/json",
      "Authorization": "bearer " + widget.userloggeddata!.Token!
    };

    if (response.statusCode == 200) {
      Map<String, dynamic> userMap = jsonDecode(response.body);
      var Package = Decodificador.fromJson(userMap);
      datapackage = Package.data;
      var package = datapackage.where((x) => x['id'] == idpackage).toList();
      CiudadesViewModel Ciudad =
          new CiudadesViewModel(userMap['ciudad_ID'], null, null, null, null);

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HotelList(
                widget.userloggeddata,
                userMap['ciudad_ID'],
                Ciudad,
                widget.reservacionEditado,
                widget.Reservacion,
                widget.PaqueteDescrip,
                widget.Precio,
                widget.idpaquete,
                widget.HotelNombre,
                widget.Actividadespaquete)),
      );
    } else {
      print("Error " + response.statusCode.toString());
    }
  }

  DateTimeRange dateRange = DateTimeRange(
      start: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day),
      end: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day + 1));

  Future pickDateRange() async {
    DateTimeRange? newDataRange = await showDateRangePicker(
      context: context,
      initialDateRange: dateRange,
      firstDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day),
      lastDate: DateTime(2100),
    );

    if (newDataRange == null) return;

    setState(() {
      dateRange = newDataRange;
      final difference = dateRange.duration.inDays;
    });
  }

  List<Padding> ResumeActivitiesExtra(
      List<dynamic>? data, BuildContext context) {
    List<Padding> list = [];
    final _controller = PageController();

    data?.forEach((element) {
      list.add(Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
        child: Container(
          height: 160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 0,
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
                      height: 0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
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
                          height: 100,
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
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 0, 0, 0),
                                      child: Text(
                                        element.acEx_Descripcion.toString(),
                                        style: TextStyle(
                                          fontFamily: 'Outfit',
                                          color: Color(0xFF090F13),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 10, 10, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        'Fecha',
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            120, 0, 0, 0),
                                        child: Text(
                                          'Hora',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 10, 10, 2),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        element.reAE_FechaReservacion
                                            .toString(),
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Color(0xFF95A1AC),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            95, 0, 0, 0),
                                        child: Text(
                                          element.reAE_HoraReservacion
                                              .toString(),
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF95A1AC),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  thickness: 2,
                                  color: Color(0xFF95A1AC),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 10, 10, 2),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        element.acEx_numeroPersonas.toString() +
                                            " personas",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Color(0xFF95A1AC),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            80, 0, 0, 0),
                                        child: Text(
                                          "HNL. " +
                                              element.reAE_Precios.toString() +
                                              '0',
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
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

  List<Padding> ReservationDetails(List<dynamic> data, BuildContext context) {
    List<Padding> list = [];
    final _controller = PageController();
    List<String> imageUrl;
    List<String> FechaLlegada;
    List<String> FechaSalida;
    data.forEach((element) {
      // imageUrl = element['image_URL'].split(',');
      FechaLlegada = element['fecha_Entrada'].split('T');
      FechaSalida = element['fecha_Salida'].split('T');
      if (widget.PaqueteDescrip == null) {
        widget.PaqueteDescrip = element['descripcionPaquete'];
      }
      if (widget.Precio == null) {
        widget.Precio = element['precio'];
        widget.reservacionEditado!.resvPrecio = Precio.toDouble();
      }
      if (widget.HotelNombre == "") {
        widget.HotelNombre = element['nombre_Hotel'];
      }
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
                  children: [],
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
                                                element['nombrecompleto'],
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 20,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 10, 0, 0),
                                                child: Text(
                                                  element['dni'],
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 16,
                                                      color: grey),
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
                                            0, 10, 0, 10),
                                        child: Text(
                                          'Paquete Incluido Del Viaje',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        )),
                                    Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 10, 0, 0),
                                        child: Container(
                                          width: double.infinity,
                                          height: 80,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Flexible(
                                                flex: 4,
                                                child: Text(
                                                  widget.PaqueteDescrip
                                                      .toString(),
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                              ),
                                              Flexible(
                                                flex: 2,
                                                child: ElevatedButton(
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(Color.fromRGBO(
                                                                101,
                                                                45,
                                                                143,
                                                                1)),
                                                    shape: MaterialStateProperty
                                                        .all(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    'Cambiar',
                                                    style: TextStyle(
                                                      fontFamily: 'Outfit',
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) => PaquetesEleccion(
                                                              widget
                                                                  .userloggeddata,
                                                              widget
                                                                  .Reservacion,
                                                              widget
                                                                  .reservacionEditado,
                                                              widget
                                                                  .PaqueteDescrip,
                                                              widget.Precio,
                                                              widget
                                                                  .HotelNombre,
                                                              widget
                                                                  .Actividadespaquete)),
                                                    );
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                        )),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 10, 0, 10),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Flexible(
                                            child: new Text(
                                                'Precio del Paquete:',
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
                                                    widget.Precio.toString(),
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
                                        padding: EdgeInsets.only(top: 0),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 16, 0, 0),
                                              child: Row(
                                                children: [
                                                  Flexible(
                                                    flex: 4,
                                                    child: Text(
                                                      "Cambiar Fecha de Llegada",
                                                      style: TextStyle(
                                                        fontFamily: 'Outfit',
                                                        color: Colors.black,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 50,
                                                  ),
                                                  Flexible(
                                                      flex: 4,
                                                      child: SizedBox(
                                                          width: 150,
                                                          child: ElevatedButton(
                                                            child: Text(
                                                              "Selec. Fecha",
                                                              style: TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255)),
                                                            ),
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              elevation: 0.0,
                                                              shadowColor: Colors
                                                                  .transparent,
                                                              backgroundColor:
                                                                  Color
                                                                      .fromRGBO(
                                                                          101,
                                                                          45,
                                                                          143,
                                                                          1),
                                                              padding:
                                                                  EdgeInsets
                                                                      .zero,
                                                            ),
                                                            onPressed: () {
                                                              pickDateRange();
                                                            },
                                                          )))
                                                ],
                                              ),
                                            )
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(top: 0),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 16, 0, 0),
                                              child: Row(
                                                children: [
                                                  Flexible(
                                                    flex: 4,
                                                    child: Text(
                                                      "Seleccione su\nfecha de Salida",
                                                      style: TextStyle(
                                                        fontFamily: 'Outfit',
                                                        color: Colors.black,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 50,
                                                  ),
                                                  Flexible(
                                                      flex: 4,
                                                      child: SizedBox(
                                                          width: 150,
                                                          child: ElevatedButton(
                                                            child: Text(
                                                              "Selec. Fecha",
                                                              style: TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255)),
                                                            ),
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              elevation: 0.0,
                                                              shadowColor: Colors
                                                                  .transparent,
                                                              backgroundColor:
                                                                  Color
                                                                      .fromRGBO(
                                                                          101,
                                                                          45,
                                                                          143,
                                                                          1),
                                                              padding:
                                                                  EdgeInsets
                                                                      .zero,
                                                            ),
                                                            onPressed: () {
                                                              pickDateRange();
                                                            },
                                                          )))
                                                ],
                                              ),
                                            )
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 20, 0, 0),
                                        child: Text(
                                          'Hotel de Hospedaje',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        )),
                                    Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 5, 0, 0),
                                        child: Container(
                                          width: double.infinity,
                                          height: 80,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Flexible(
                                                flex: 6,
                                                child: Text(
                                                  widget.HotelNombre,
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 120,
                                              ),
                                              Flexible(
                                                flex: 6,
                                                child: ElevatedButton(
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(Color.fromRGBO(
                                                                101,
                                                                45,
                                                                143,
                                                                1)),
                                                    shape: MaterialStateProperty
                                                        .all(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    'Cambiar',
                                                    style: TextStyle(
                                                      fontFamily: 'Outfit',
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    FindPackages(
                                                        element['id_Paquete'],
                                                        widget.userloggeddata);
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                        )),
                                    Wrap(
                                        spacing: 8,
                                        runSpacing: 4,
                                        alignment: WrapAlignment.start,
                                        crossAxisAlignment:
                                            WrapCrossAlignment.start,
                                        direction: Axis.horizontal,
                                        runAlignment: WrapAlignment.start,
                                        verticalDirection:
                                            VerticalDirection.down,
                                        clipBehavior: Clip.none,
                                        children: ResumeActivitiesExtra(
                                            widget.Actividadespaquete,
                                            context)),
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
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      widget.reservacionEditado!.paquId = widget.idpaquete;
      widget.reservacionEditado!.hoteId = element['hotel_ID'];
      widget.reservacionEditado!.reHoFechaEntrada =
          DateFormat('yyyy-MM-dd').format(dateRange.start);
      widget.reservacionEditado!.reHoFechaSalida =
          DateFormat('yyyy-MM-dd').format(dateRange.end);
      widget.reservacionEditado!.resvId = element['id'];
      widget.reservacionEditado!.resvPrecio = widget.Precio;
      widget.reservacionEditado!.resvNumeroPersonas = element['numeroPersonas'];
      widget.reservacionEditado!.resvCantidadPagos = element['cantidadPagos'];
      widget.reservacionEditado!.usuaId = element['id_Cliente'];
      widget.reservacionEditado!.resvConfirmacionHotel = false;
      widget.reservacionEditado!.resvConfirmacionPago = false;
      widget.reservacionEditado!.resvConfirmacionRestaurante = false;
      widget.reservacionEditado!.resvConfirmacionTrans = false;
      widget.reservacionEditado!.resvEsPersonalizado = false;
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
                          future: GetReservation(),
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
                                    children: ReservationDetails(
                                        widget.Reservacion, context));
                              } else {
                                return Center(child: Text("No data"));
                              }
                            }
                          },
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ));
  }
}
