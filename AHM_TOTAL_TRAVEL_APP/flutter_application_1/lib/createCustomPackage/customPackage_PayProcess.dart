import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_1/Components/Packages.dart';
import 'package:flutter_application_1/ComponentsLogin/Decoder.dart';
import 'package:flutter_application_1/Models/customPackageViewModel.dart';
import 'package:flutter_application_1/createCustomPackage/customPackage_Success.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart';
import '../Components/Decodificador.dart';
import '../ComponentsLogin/constants.dart';
import '../Models/DefaultPackageViewModel.dart';
import '../Models/ReservationViewModel.dart';
import '../Models/UsersViewModel.dart'; //https://pub.dev/packages/nb_utils

class PayProcess extends StatefulWidget {
  final UserLoggedModel? userloggeddata;
  final customPackageViewModel customPackage;
  const PayProcess(this.userloggeddata,this.customPackage,{super.key});

  static String tag = '/ReservConfirm';

  @override
  _PayProcess createState() => _PayProcess();
}

class _PayProcess extends State<PayProcess> {
  TextEditingController MontoPago = TextEditingController();

  Future<dynamic> GetPaymentType() async {
    String url_list =
        "https://totaltravelapi.azurewebsites.net/API/PaymentTypes/List";
    final response = await http.get(Uri.parse(url_list));
    if (response.statusCode == 200) {
      Map<String, dynamic> userMap = jsonDecode(response.body);
      var user = Decodificador.fromJson(userMap);
      return user.data;
    } else {
    }
  }
  var cantidadFinal = 1;



Future<void> PostCustomPackages(customPackageViewModel customPackage, UserLoggedModel userloggeddata)async {

  final url = Uri.parse("https://totaltravelapi.azurewebsites.net/API/Reservation/Insert");
  final headers = {
      "Content-type": "application/json",
      "Authorization": "bearer " + widget.userloggeddata!.Token!
    };
  final json = jsonEncode(customPackage);
  final response = await post(url, headers: headers, body: json);
  var idPackage;
  if (response.body != " ") {
    Map<String, dynamic> userMap = jsonDecode(response.body);
    var data = DecoderAPI.fromJson(userMap);
    idPackage = response.statusCode;
    if (data.data != null) {
      
      final url = Uri.parse("https://totaltravelapi.azurewebsites.net/API/Reservation/Insert");
      final headers = {
          "Content-type": "application/json",
          "Authorization": "bearer " + widget.userloggeddata!.Token!
        };
      final json = jsonEncode(customPackage);
      final response = await post(url, headers: headers, body: json);

       Navigator.push( context,MaterialPageRoute(builder: (context) =>   SuccessCustomPackage(widget.userloggeddata,widget.customPackage)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: white,
        content: Text(
          textAlign: TextAlign.center,
          'Ha ocurrido un error, intentelo denuevo más tarde.',
          style: TextStyle(color: redColor, fontSize: 16),
        ),
      ));
    }
  }
}






  List<Padding> ListPaymenttype(
      List<dynamic> data, BuildContext context, user) {
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
                          height: 90,
                          decoration: BoxDecoration(
                            color: Color(0xFF652D8F),
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
                                      element['descripcion'],
                                      style: TextStyle(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF090F13),
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 0, 10, 0),
                                      child: Container(
                                        width: 120,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              getColorFromHex('#8998FF'),
                                              getColorFromHex('#FF652D8F')
                                            ],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: CupertinoButton(
                                          child: Text('Elegir',
                                              style: primaryTextStyle(
                                                  color: white, size: 15)),
                                          onPressed: () {
                                            showModalBottomSheet<void>(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Container(
                                                  height: 300,
                                                  color: Colors.white,
                                                  child: Center(
                                                    child: Column(
                                                      children: <Widget>[
                                                        Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 20, 0, 0),
                                        child: Text(
                                         "Cantidad de pagos",
                                          style: TextStyle(
                                            fontFamily: 'Outfit',
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            
                                          ),
                                        ),
                                      ),
                                         Padding(
                                                              padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
                                                              child: SpinBox(
                                                                max: 10,
                                                                min: 1,
                                                                value: 1,
                                                                onChanged:
                                                                    (valuePeople) {
                                                                  setState(() {
                                                                    cantidadFinal = valuePeople.toInt();
                                                                  
                                                                  });
                                                                },
                                                              ),
                                                             
                                                            ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      30, 0, 0),
                                                          child: Text(
                                                            "Indique el monto a pagar para reservar",
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Outfit',
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(20,
                                                                      5, 20, 0),
                                                          child: TextFormField(
                                                            style:
                                                                kTextFormFieldStyle(),
                                                            keyboardType:
                                                                TextInputType
                                                                    .phone,
                                                            decoration:
                                                                const InputDecoration(
                                                              prefixIcon: Icon(Icons
                                                                  .monetization_on),
                                                              hintText:
                                                                  '0',
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            15)),
                                                              ),
                                                            ),                                                      
                                                            // The validator receives the text that the user has entered.
                                                            validator: (value) {
                                                              if (value ==
                                                                      null ||
                                                                  value
                                                                      .isEmpty) {
                                                                return 'Rellene este campo';
                                                              } else {
                                                                MontoPago.text =
                                                                    value;
                                                              }
                                                              return null;
                                                            },
                                                          ),
                                                        ),
                                                        // Phone
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      15, 0, 0),
                                                          child: SizedBox(
                                                            width: 240,
                                                            height: 40,
                                                            child:
                                                                ElevatedButton(
                                                              onPressed: () {
                                                                widget.customPackage.tipoPago = element['id'];
                                                                widget.customPackage.CantidadPagos = cantidadFinal;
                                                              

                                                                PostCustomPackages(widget.customPackage, widget.userloggeddata!);
                                                                
                                                              },
                                                              child: Text(
                                                                'Confirmar',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18),
                                                              ),
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                primary: Color(
                                                                    0xFF652D8F),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ).paddingAll(8.0),
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
    });

    return list;
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
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
                  '',
                ),
              ),
              Expanded(
                flex: 5,
                child: Center(
                  child: Text(
                    '',
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
        body: ListView(
          children: <Widget>[
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
                      children: ListPaymenttype(
                          snapshot.data, context, widget.userloggeddata));
                } else {
                  return Center(
                      child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 350, 0, 0),
                    child: CircularProgressIndicator(
                        color: Color.fromARGB(255, 101, 45, 144)),
                  ));
                }
              },
              future: GetPaymentType(),
            ),
          ],
        ),
      ),
    );
  }
}
