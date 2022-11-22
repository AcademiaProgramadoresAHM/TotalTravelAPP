import 'package:flutter/material.dart';
import 'package:flutter_application_1/home_screen.dart';

import '../Components/Packages.dart';
import '../Models/DefaultPackageViewModel.dart';
import '../Models/ReservationViewModel.dart';
import '../Models/UsersViewModel.dart';
import '../navigation_home_screen.dart';
import 'package:flutter_application_1/DefaultPackageScreens/ReservConfirm.dart';

class ReservationPreview extends StatefulWidget {
  final UserLoggedModel? userloggeddata;
  final ReservationViewmodel Reservation;
  final DefaultPackageModel? package;
  final List<dynamic> paqueteactividades;
  final List<ActivitiesExtraDefault>? actividadesExtra;

  const ReservationPreview(this.userloggeddata, this.Reservation, this.package,
      this.paqueteactividades, this.actividadesExtra,
      {super.key});
  @override
  State<ReservationPreview> createState() => _ReservationPreviewState();
}

class _ReservationPreviewState extends State<ReservationPreview> {
  num SubTotal = 0;
  List<Padding> ResumeActivities(List<dynamic> data, BuildContext context) {
    List<Padding> list = [];
    final _controller = PageController();
    if (data.length == 0) {
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
                                        'No Incluye Actividades este Paquete',
                                        style: TextStyle(
                                          fontFamily: 'Outfit',
                                          color: Color(0xFF090F13),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    )
                                  ],
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
    } else {
      data.forEach((element) {
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
                                          'Actividad',
                                          style: TextStyle(
                                            fontFamily: 'Outfit',
                                            color: Color(0xFF090F13),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 10, 10, 2),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          element['descripcionActividad']
                                              .toString(),
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF95A1AC),
                                            fontSize: 16,
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
    }

    return list;
  }

//Listado de actividades extras
  List<Padding> ResumeActivitiesExtra(
      List<ActivitiesExtraDefault>? data, BuildContext context) {
    List<Padding> list = [];
    final _controller = PageController();

    data?.forEach((element) {
      setState(() {
        SubTotal = SubTotal + num.parse(element.reAE_Precios.toString());
      });
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

//Resumen de pago
  List<Padding> ResumePay(ReservationViewmodel data, BuildContext context) {
    List<Padding> list = [];
    final _controller = PageController();
    List<String> imageUrl;
    list.add(Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 4),
      child: Container(
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
                  padding: EdgeInsetsDirectional.fromSTEB(10, 10, 16, 12),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: 4,
                        height: 250,
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
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(8, 4, 8, 4),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [],
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 0, 0, 20),
                                    child: Text(
                                      widget.package!.nombre.toString(),
                                      style: TextStyle(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF090F13),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 0, 10, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'Entrada',
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          120, 0, 0, 0),
                                      child: Text(
                                        'Salida',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 0, 10, 2),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      widget.Reservation.reHo_FechaEntrada
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
                                        widget.Reservation.reHo_FechaSalida
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
                                    0, 10, 0, 10),
                                child: Align(
                                  alignment: AlignmentDirectional(-0.9, 0),
                                  child: Text(
                                    'Duración de la estancia:',
                                  ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(-0.9, 0),
                                child: Text(
                                  widget.package!.duracionPaquete.toString() +
                                      ' Días',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF95A1AC),
                                  ),
                                ),
                              ),
                              Divider(
                                thickness: 2,
                                color: Color(0xFF95A1AC),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 10, 0, 10),
                                child: Align(
                                  alignment: AlignmentDirectional(-0.9, 0),
                                  child: Text(
                                    'Hotel de Hospedaje:',
                                  ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(-0.9, 0),
                                child: Text(
                                  widget.package!.hotel.toString() +
                                      ' - ' +
                                      widget.package!.descripcionHotel
                                          .toString(),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF95A1AC),
                                  ),
                                ),
                              ),
                              Divider(
                                thickness: 2,
                                color: Color(0xFF95A1AC),
                              ),
                              Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 0)),
                              Align(
                                alignment: AlignmentDirectional(-0.9, 0),
                                child: Text(
                                  'Detalles',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 10, 10, 2),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional(-0.8, 0),
                                      child: Text(
                                        widget.Reservation.resvNumeroPersonas
                                                .toString() +
                                            ' Personas',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF95A1AC),
                                            fontSize: 16),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          110, 0, 0, 0),
                                      child: Text(
                                        "LPS. " +
                                            widget.Reservation.resvPrecio
                                                .toString(),
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
    ;
    return list;
  }

//Listado de Restaurantes Incluidos

  List<Padding> ResumeRestaurant(
      ReservationViewmodel data, BuildContext context) {
    List<Padding> list = [];
    final _controller = PageController();

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
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 0, 0, 0),
                                    child: Text(
                                      widget.package!.restaurante.toString(),
                                      style: TextStyle(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF090F13),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              // Divider(
                              //   thickness: 2,
                              //   color: Color(0xFF95A1AC),
                              // ),
                              // Padding(
                              //   padding: EdgeInsetsDirectional.fromSTEB(
                              //       10, 10, 10, 0),
                              //   child: Row(
                              //     mainAxisSize: MainAxisSize.max,
                              //     children: [
                              //       Text(
                              //         widget.package!.restaurante.toString(),
                              //       ),
                              //     ],
                              //   ),
                              // ),
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

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter layout demo',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xFF652D8F),
              automaticallyImplyLeading: false,
              title: Align(
                alignment: AlignmentDirectional(0, -0.05),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(60, 15, 0, 10),
                  child: Text(
                    'Resumen de pago',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontSize: 23,
                    ),
                  ),
                ),
              ),
              actions: [
                Align(
                  alignment: AlignmentDirectional(-0.05, 0.05),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                    child: Image.asset(
                      'assets/images/logo-AHM-Fondo-Morao.png',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
              centerTitle: false,
              elevation: 2,
            ),
            body: SingleChildScrollView(
                // color:
                //     HotelAppTheme.buildLightTheme().backgroundColor,
                child: Column(
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(30, 4, 8, 4),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: Icon(
                          Icons.assignment_sharp,
                          color: Color(0xFF0F1113),
                          size: 24,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(12, 20, 0, 0),
                        child: Text(
                          'Paquete',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
                Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    direction: Axis.horizontal,
                    runAlignment: WrapAlignment.start,
                    verticalDirection: VerticalDirection.down,
                    clipBehavior: Clip.none,
                    children: ResumePay(widget.Reservation, context)),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(30, 4, 8, 4),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: Icon(
                          Icons.assignment_sharp,
                          color: Color(0xFF0F1113),
                          size: 24,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(12, 20, 0, 0),
                        child: Text('Actividades del Paquete',
                            style: TextStyle(fontSize: 18)),
                      ),
                    ],
                  ),
                ),
                Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    direction: Axis.horizontal,
                    runAlignment: WrapAlignment.start,
                    verticalDirection: VerticalDirection.down,
                    clipBehavior: Clip.none,
                    children:
                        ResumeActivities(widget.paqueteactividades, context)),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(30, 4, 8, 4),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: Icon(
                          Icons.assignment_sharp,
                          color: Color(0xFF0F1113),
                          size: 24,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(12, 20, 0, 0),
                        child: Text('Actividades Extras Añadidas al Paquete',
                            style: TextStyle(fontSize: 18)),
                      ),
                    ],
                  ),
                ),
                Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    direction: Axis.horizontal,
                    runAlignment: WrapAlignment.start,
                    verticalDirection: VerticalDirection.down,
                    clipBehavior: Clip.none,
                    children: ResumeActivitiesExtra(
                        widget.actividadesExtra, context)),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(30, 4, 8, 4),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: Icon(
                          Icons.assignment_sharp,
                          color: Color(0xFF0F1113),
                          size: 24,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(12, 20, 0, 0),
                        child: Text('Restaurante Incluido',
                            style: TextStyle(fontSize: 18)),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 60),
                    child: Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        alignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        direction: Axis.horizontal,
                        runAlignment: WrapAlignment.start,
                        verticalDirection: VerticalDirection.down,
                        clipBehavior: Clip.none,
                        children:
                            ResumeRestaurant(widget.Reservation, context))),
              ],
            )),
            bottomNavigationBar: Row(
              children: [
                Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                    child: SizedBox(
                      width: 175,
                      height: 35,
                      child: ElevatedButton(
                        onPressed: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                              child: Text(
                                '¿Esta seguro que desea continuar?',
                              ),
                            ),
                            actions: <Widget>[
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Color.fromARGB(255, 234, 234, 234),
                                  ),
                                  child: Text(
                                    "Cancelar",
                                    style: TextStyle(color: Color(0xFF652D8F)),
                                  )),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              NavigationHomeScreen(
                                                  MyHomePage(
                                                      widget.userloggeddata),
                                                  widget.userloggeddata)),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xFF652D8F),
                                  ),
                                  child: Text("Aceptar"))
                            ],
                          ),
                        ),
                        child: Text(
                          'Regresar',
                          style:
                              TextStyle(fontSize: 18, color: Color(0xFF652D8F)),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 234, 234, 234),
                        ),
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 170,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NavigationHomeScreen(
                                      ReservConfirm(
                                        widget.userloggeddata,
                                        widget.Reservation,
                                      ),
                                      userloggeddata)));
                        },
                        child: Text(
                          'Confirmar',
                          style: TextStyle(fontSize: 18),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF652D8F),
                        ),
                      ),
                    )),
              ],
            )));
  }
}
