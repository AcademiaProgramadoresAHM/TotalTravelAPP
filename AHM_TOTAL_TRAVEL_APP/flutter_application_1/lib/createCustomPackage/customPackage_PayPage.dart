import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/CitiesViewModel.dart';
import 'package:flutter_application_1/Models/UsersViewModel.dart';
import 'package:flutter_application_1/Models/customPackageViewModel.dart';
import 'package:flutter_application_1/createCustomPackage/customPackage_Create.dart';
import 'package:flutter_application_1/hotel_booking/hotel_app_theme.dart';
import 'package:flutter_application_1/utils/prueba2/AppWidget.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/Screens/prueba.dart';
import 'package:flutter_application_1/Screens/signUp_view.dart';
import 'package:flutter_application_1/navigation_home_screen.dart';

class payPage extends StatefulWidget {
  final customPackageViewModel customPackage;
    final UserLoggedModel? userloggeddata;
  final CiudadesViewModel? Ciudad;
  const payPage( this.customPackage,this.userloggeddata,this.Ciudad,{Key? key}) : super(key: key);

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
    List<Padding> list = [];
    final _controller = PageController();
    List<String> imageUrl;
      list.add(
        
        Padding(
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
                                  ],
                                ),
                              ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(padding: EdgeInsetsDirectional.fromSTEB(10, 0,0,20),
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
                                  Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 10, 10, 2),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
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
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          110, 0, 0, 0),
                                      child: Text(
                                        "LPS. " + widget.customPackage.reHo_PrecioTotal.toString(),
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15
      
                                        ),
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




List<Padding> ResumeActivities(List<ActivitiesExtra>? data, BuildContext context) {
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
                                    Padding(padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                    child: Text(
                                      element.acEx_Descripcion.toString(),
                                      style: TextStyle(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF090F13),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),)
                                   
                                  
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
                                      element.reAE_FechaReservacion.toString(),
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Color(0xFF95A1AC),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          95, 0, 0, 0),
                                      child: Text(
                                        element.reAE_HoraReservacion.toString(),
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
                                      element.acEx_numeroPersonas.toString() + " personas",
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Color(0xFF95A1AC),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          110, 0, 0, 0),
                                      child: Text(
                                        "LPS. " + element.reAE_Precios.toString(),
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15
                                        ),
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






List<Padding> ResumeRestaurant(List<Restaurants>? data, BuildContext context) {
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
                                    Padding(padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                    child: Text(
                                      element.restaurante.toString(),
                                      style: TextStyle(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF090F13),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),)
                                   
                                  
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
                                      element.rest_FechaReservacion.toString(),
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Color(0xFF95A1AC),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          95, 0, 0, 0),
                                      child: Text(
                                        element.rest_HoraReservacion.toString(),
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
                                      element.rest_numeroPersonas.toString() + " personas",
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Color(0xFF95A1AC),
                                      ),
                                    ),
                                    /*Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          110, 0, 0, 0),
                                      child: Text(
                                        "LPS. " + element..toString(),
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15
                                        ),
                                      ),
                                    ),*/
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
               Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(30, 4, 8, 4),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 20, 0, 0),
                                      child: Icon(
                                        Icons.assignment_sharp,
                                        color: Color(0xFF0F1113),
                                        size: 24,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12, 20, 0, 0),
                                      child: Text(
                                        'Hotel',style: TextStyle(fontSize: 18),
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
                        children: ResumePay(widget.customPackage, context)),
                             Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(30, 4, 8, 4),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 20, 0, 0),
                                      child: Icon(
                                        Icons.assignment_sharp,
                                        color: Color(0xFF0F1113),
                                        size: 24,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12, 20, 0, 0),
                                      child: Text(
                                        'Actividades',style: TextStyle(fontSize: 18)
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
                        children: ResumeActivities(widget.customPackage.actividadesExtra, context)),
                         Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(30, 4, 8, 4),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 20, 0, 0),
                                      child: Icon(
                                        Icons.assignment_sharp,
                                        color: Color(0xFF0F1113),
                                        size: 24,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12, 20, 0, 0),
                                      child: Text(
                                        'Restaurante',style: TextStyle(fontSize: 18)
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                         Padding(padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 60),
                         child: Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        alignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        direction: Axis.horizontal,
                        runAlignment: WrapAlignment.start,
                        verticalDirection: VerticalDirection.down,
                        clipBehavior: Clip.none,
                        children: ResumeRestaurant(widget.customPackage.Restaurant, context))),       
                         
        ],
      )),
       bottomNavigationBar: Row(children: [
        Padding(
        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
        child:
        SizedBox( 
          width: 175,
          height: 35,
          child:     ElevatedButton(
          onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Padding(padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
          child: Text('¿Esta seguro que desea continuar?',),
          ) ,
          actions: <Widget>[
          ElevatedButton(onPressed: () {
             Navigator.pop(context);
          },
           style: ElevatedButton.styleFrom(
            primary:  Color.fromARGB(255, 234, 234, 234),
          ),
          child: Text("Cancelar",style: TextStyle(color: Color(0xFF652D8F)),)),
          ElevatedButton(onPressed: () {
            Navigator.push( context,MaterialPageRoute(builder: (context) =>  NavigationHomeScreen(createCustomPackage(widget.Ciudad,widget.userloggeddata,3,widget.customPackage),widget.userloggeddata)),);
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
            style: TextStyle(fontSize: 18,color: Color(0xFF652D8F)),
          ),
          style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(255, 234, 234, 234),
          ),
        ),)
     
      ),
      Padding(
        padding: EdgeInsets.all(8.0),
        child:
        SizedBox( 
          width: 170,
          child:     ElevatedButton(
          onPressed: () {
           
          },
          child: Text(
            'Confirmar',
            style: TextStyle(fontSize: 18),
          ),
          style: ElevatedButton.styleFrom(
            primary: Color(0xFF652D8F),
          ),
        ),)
     
      ),
       ],)
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
