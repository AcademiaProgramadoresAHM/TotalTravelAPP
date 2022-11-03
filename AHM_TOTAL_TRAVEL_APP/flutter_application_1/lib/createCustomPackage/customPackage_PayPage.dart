import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/customPackageViewModel.dart';
import 'package:flutter_application_1/hotel_booking/hotel_app_theme.dart';
import 'package:flutter_application_1/utils/prueba2/AppWidget.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/Screens/prueba.dart';
import 'package:flutter_application_1/Screens/signUp_view.dart';
import 'package:flutter_application_1/navigation_home_screen.dart';

class payPage extends StatefulWidget {
  final customPackageViewModel customPackage;
  const payPage( this.customPackage,{Key? key}) : super(key: key);

  @override
  State<payPage> createState() => _payPage();
}

class _payPage extends State<payPage> {
  String? radioButtonValue;
  TextEditingController? textController1;
  TextEditingController? textController2;
  TextEditingController? textController3;
  final scaffoldKey = GlobalKey<ScaffoldState>();

 

  List<Padding> ResumePay(customPackageViewModel data, BuildContext context) {
    List<Restaurants>? restaurante = widget.customPackage.Restaurant;
    List<ActivitiesExtra>? Activity = widget.customPackage.actividadesExtra;

    List<Padding> list = [];
    final _controller = PageController();
    List<String> imageUrl;
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
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
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
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 2, 0, 0),
                                      child: Icon(
                                        Icons.assignment_sharp,
                                        color: Color(0xFF0F1113),
                                        size: 24,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12, 0, 0, 0),
                                      child: Text(
                                        'Hotel',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(padding: EdgeInsetsDirectional.fromSTEB(43, 0,0,20),
                                    child:Text(
                                      data.hote_Descripcion.toString(),
                                      style: TextStyle(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF090F13),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),)
                                    
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
                                     widget.customPackage.reHo_FechaEntrada.toString(),
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Color(0xFF95A1AC),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          95, 0, 0, 0),
                                      child: Text(
                                        widget.customPackage.reHo_FechaSalida.toString(),
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
                              Padding(padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0,10),
                              child:  Align(
                                alignment: AlignmentDirectional(-0.9, 0),
                                child: Text(
                                  'Duración de la estancia:',
                                ),
                              ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(-0.9, 0),
                                child: Text(
                                   widget.customPackage.hote_numNoches.toString() + ' ' + widget.customPackage.night.toString(),
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
                               Padding(padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0)),
                              Align(
                                alignment: AlignmentDirectional(-0.9, 0),
                                child: Text(
                                  'Tu selección:',
                                  style: TextStyle(
                                    fontSize: 16
                                  ),
                                ),
                              ),
                              
                              Align(
                                alignment: AlignmentDirectional(-0.6, 0),
                                child: Text(
                                  widget.customPackage.habi_Descripcion.toString() + '    -     ' + widget.customPackage.habi_Cantidad.toString() + ' ' + widget.customPackage.room.toString(),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    color: Color(0xFF95A1AC),
                                  ),
                                ),
                              ),
                              Padding(padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0)),
                              Align(
                                alignment: AlignmentDirectional(-0.9, 0),
                                child: Text(
                                  'Detalles',
                                  style: TextStyle(
                                    fontSize: 16
                                  ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(-0.8, 0),
                                child: Text(
                                  widget.customPackage.hote_numeroPersonas.toString() + ' ' + widget.customPackage.people.toString(),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF95A1AC),
                                    fontSize: 16
                                  ),
                                ),
                              ),
                              Divider(),
                               Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(8, 4, 8, 4),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 2, 0, 0),
                                      child: Icon(
                                        Icons.assignment_sharp,
                                        color: Color(0xFF0F1113),
                                        size: 24,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12, 0, 0, 0),
                                      child: Text(
                                        'Actividades',
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


  @override
  void initState() {
    super.initState();
    //GetListHotels(widget.Ciudad,widget.userloggeddata);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    changeStatusColor(appStore.appBarColor);
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
              Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        alignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        direction: Axis.horizontal,
                        runAlignment: WrapAlignment.start,
                        verticalDirection: VerticalDirection.down,
                        clipBehavior: Clip.none,
                        children: ResumePay(widget.customPackage, context))
        ],
      )),
    ));
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
