import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/Components/ShoppingHistory.dart';
import 'package:flutter_application_1/Models/CitiesViewModel.dart';
import 'package:flutter_application_1/Models/UsersViewModel.dart';
import 'package:flutter_application_1/Models/customPackageViewModel.dart';
import 'package:flutter_application_1/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/detallesdehistorial.dart';
import 'package:flutter_application_1/createCustomPackage/customPackage_Activities.dart';
import 'package:flutter_application_1/createCustomPackage/customPackage_Restaurants.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import '../Components/Decodificador.dart';
import '../hotel_booking/hotel_app_theme.dart';

class HistoryRestaurants extends StatefulWidget {
  final UserLoggedModel? userloggeddata;
  final List<Restaurants> Restaurant;
  final int RestaurantAdd;
  final CiudadesViewModel? Ciudad;
  final customPackageViewModel customPackage;
  final Map<int?, String> CitiesDictionary;
  const HistoryRestaurants(this.userloggeddata,this.Restaurant,this.RestaurantAdd,this.Ciudad,this.customPackage,this.CitiesDictionary, {Key? key}) : super(key: key);
  @override
  _HistoryRestaurants createState() => _HistoryRestaurants();
}
      int RestaurantCounter = 1;
class _HistoryRestaurants extends State<HistoryRestaurants> { 

  List<Padding> ListActivitiesExtra(List<Restaurants> data, BuildContext context) {
    List<Padding> list = [];
    final _controller = PageController();

    data.forEach((element) {
      list.add(Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 4),
        child: Container(
          height: 248,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
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
                                      element.restaurante.toString(),
                                      style: TextStyle(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF090F13),
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  
                                  ],
                                ),
                                Padding(padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                                child:Text(
                                  "Personas: "+element.rest_numeroPersonas.toString(),
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    color: Color.fromRGBO(101, 45, 143, 1),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ), ),
                                
                                Text(
                                  "Fecha: "+element.rest_FechaReservacion.toString(),
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    color: Color.fromRGBO(101, 45, 143, 1),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "Hora: " + element.rest_HoraReservacion.toString(),
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    color: Color.fromRGBO(101, 45, 143, 1),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
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
                                            2, 12, 24, 0),
                                      ),
                                      ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.red.shade900),
                                          shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          'Quitar',
                                          style: TextStyle(
                                            fontFamily: 'Outfit',
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        onPressed: () {

                                              if(widget.RestaurantAdd != 0){
                                                RestaurantCounter = widget.RestaurantAdd - 1;
                                              }
                                               

                                            widget.Restaurant.removeAt(element.index!);
                                        Navigator.push(context,MaterialPageRoute(builder: (context) => HistoryRestaurants(widget.userloggeddata,widget.Restaurant,RestaurantCounter,widget.Ciudad,widget.customPackage,widget.CitiesDictionary)),);

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
                    'Tus restaurantes',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 25,
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
                          ListActivitiesExtra(widget.Restaurant, context)),
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
          onPressed: () => showCupertinoDialog(
                            context: context,
                            builder: (BuildContext context) => Theme(
                                  data: ThemeData.light(),
                                  child: CupertinoAlertDialog(
                                    title: Text(
                                      'Advertencia',
                                      style: boldTextStyle(
                                          color: Colors.black, size: 18),
                                    ),
                                    content: Text(
                                      '¿Está seguro de continuar?',
                                      style: secondaryTextStyle(
                                          color: Colors.black, size: 16),
                                    ),
                                    actions: [
                                      CupertinoDialogAction(
                                        child: Text(
                                          'Cancelar',
                                          style: primaryTextStyle(
                                              color: dodgerBlue, size: 18),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      CupertinoDialogAction(
                                        child: Text(
                                          'Aceptar',
                                          style: primaryTextStyle(
                                              color: redColor, size: 18),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  ),
                                )),
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
           
               Navigator.push(
                        context,
                    MaterialPageRoute(
                    builder: (context) =>
                         RestaurantcustomPackage(widget.userloggeddata,widget.Ciudad,widget.customPackage,RestaurantCounter,widget.Restaurant,widget.CitiesDictionary)),
                      );
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
