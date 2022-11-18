import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_1/Components/Packages.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';

import '../Components/Decodificador.dart';
import '../ComponentsLogin/constants.dart';
import '../Models/DefaultPackageViewModel.dart';
import '../Models/ReservationViewModel.dart';
import '../Models/UsersViewModel.dart';
import '../Models/registerpaymentViewModel.dart'; //https://pub.dev/packages/nb_utils

class ReservConfirm extends StatefulWidget {
  final UserLoggedModel? userloggeddata;
  final ReservationViewmodel Reservation;
  // final DefaultPackageModel? package;
  // final List<dynamic> paqueteactividades;

  const ReservConfirm(this.userloggeddata, this.Reservation, {super.key});

  static String tag = '/ReservConfirm';

  @override
  ReservConfirmState createState() => ReservConfirmState();
}

class ReservConfirmState extends State<ReservConfirm> {
  TextEditingController MontoPago = TextEditingController();
  ModelDataRecordPayment dataPayment = new ModelDataRecordPayment();
  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted = formatter.format(now);

  Future<dynamic> GetPaymentType() async {
    String url_list =
        "https://apitotaltravel.azurewebsites.net/API/PaymentTypes/List";
    final response = await http.get(Uri.parse(url_list));
    if (response.statusCode == 200) {
      Map<String, dynamic> userMap = jsonDecode(response.body);
      var user = Decodificador.fromJson(userMap);
      return user.data;
    } else {
      print("Error " + response.statusCode.toString());
    }
  }

  Future<dynamic> FindPayment(idPayment, userloggeddata) async {
    List<dynamic> datapayment;
    String url_list =
        "https://apitotaltravel.azurewebsites.net/API/PaymentTypes/List";
    final headers = {
      "Content-type": "application/json",
      "Authorization": "bearer " + widget.userloggeddata!.Token!
    };
    final response = await http.get(Uri.parse(url_list), headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> userMap = jsonDecode(response.body);
      var Json = Decodificador.fromJson(userMap);
      datapayment = Json.data;
      var payment = datapayment.where((x) => x['id'] == idPayment).toList();

      dataPayment.idpayment = idPayment;
      dataPayment.monto = MontoPago.text.toDouble();
      dataPayment.formatted = formatted;

      PostReservertion(
          widget.Reservation.resvPrecio,
          widget.Reservation.hotelid,
          widget.Reservation,
          dataPayment,
          widget.userloggeddata,
          context);
    } else {
      print("Error " + response.statusCode.toString());
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
                                    Flexible(
                                      flex: 6,
                                      child: Text(
                                        element['descripcion'],
                                        style: TextStyle(
                                          fontFamily: 'Outfit',
                                          color: Color(0xFF090F13),
                                          fontSize: 26,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20, 0, 20, 0),
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
                                                  color: white, size: 18)),
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
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      30, 0, 0),
                                                          child: Text(
                                                            "Primero Pago a realizar",
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
                                                                  .fromSTEB(30,
                                                                      5, 30, 0),
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
                                                                  'Primer Pago',
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
                                                                FindPayment(
                                                                    element[
                                                                        'id'],
                                                                    widget
                                                                        .userloggeddata);
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
                  '  ',
                ),
              ),
              Expanded(
                flex: 5,
                child: Center(
                  child: Text(
                    'Paquetes Predeterminados',
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
