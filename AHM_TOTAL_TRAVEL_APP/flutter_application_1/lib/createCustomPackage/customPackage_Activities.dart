import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/ComponentsLogin/Decoder.dart';
import 'package:flutter_application_1/Models/HotelsViewModel.dart';
import 'package:flutter_application_1/Models/customPackageViewModel.dart';
import 'package:flutter_application_1/createCustomPackage/customPackage_ActivityDetails.dart';
import 'package:flutter_application_1/createCustomPackage/customPackage_Create.dart';
import 'package:flutter_application_1/createCustomPackage/customPackage_HistoryActivities.dart';
import 'package:flutter_application_1/navigation_home_screen.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;
import '../Models/CitiesViewModel.dart';
import '../Models/UsersViewModel.dart';
import '../utils/models.dart';
import '../utils/AppWidget.dart';
import '../utils/T2Colors.dart';
import '../utils/ListaHoteles.dart';
import '../utils/flutter_rating_bar.dart';

class customActivities extends StatefulWidget {
  static var tag = "/DemoT2Cards";
  final UserLoggedModel? userloggeddata;
  final CiudadesViewModel? Ciudad;
  final int ActivitiesAdd;
  final List<ActivitiesExtra> activityExtra;
  final customPackageViewModel customPackage;
  final Map<int?, String> CitiesDictionary;
  const customActivities(this.userloggeddata, this.Ciudad, this.ActivitiesAdd,
      this.customPackage, this.activityExtra, this.CitiesDictionary,
      {super.key});
  @override
  _customActivities createState() => _customActivities();
}

TimeOfDay time =
    TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);

class _customActivities extends State<customActivities> {
  late List<Hoteles> ListaHoteles;
  Map<int?, String> HotelsDictionary = Map();

  Future<dynamic> GetListActivities(
      Ciudad, userloggeddata, idActivity, bool, ActivitiesCount) async {
    List<dynamic> dataActivities;
    String url_list =
        "https://totaltravelapi.azurewebsites.net/API/ActivitiesExtra/List";
    final headers = {
      "Content-type": "application/json",
      "Authorization": "bearer " + widget.userloggeddata!.Token!
    };
    final response = await http.get(Uri.parse(url_list), headers: headers);
    if (bool == true) {
      if (response.statusCode == 200) {
        Map<String, dynamic> userMap = jsonDecode(response.body);
        var Json = DecoderAPI.fromJson(userMap);
        dataActivities = Json.data;
        var activity =
            dataActivities.where((x) => x['ciudadID'] == Ciudad.ID).toList();

        return activity;
      }
    } else if (bool == false) {
      if (response.statusCode == 200) {
        Map<String, dynamic> userMap = jsonDecode(response.body);
        var Json = DecoderAPI.fromJson(userMap);
        dataActivities = Json.data;
        var Activity =
            dataActivities.where((x) => x['id'] == idActivity).toList();
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ActivityDetails(
                  widget.userloggeddata,
                  Activity,
                  Ciudad,
                  ActivitiesCount,
                  widget.customPackage,
                  widget.activityExtra,
                  widget.CitiesDictionary)),
        );
      }
    } else {
      final url_list = Uri.parse(
          "https://totaltravelapi.azurewebsites.net/API/Authentication/Refresh-token");
      final headers = {
        "Content-type": "application/json",
        "Authorization": "bearer " + widget.userloggeddata!.Token!
      };

      final json = jsonEncode({"token": widget.userloggeddata!.Token});
      final response = await http.post(url_list, headers: headers, body: json);
      if (response.body != " ") {
        widget.userloggeddata!.Token = response.body;
        GetListActivities(
            Ciudad, widget.userloggeddata, null, true, ActivitiesCount);
      }
    }
  }

  List<Padding> ListActivities(List<dynamic> data, BuildContext context) {
    final hours = time.hour.toString().padLeft(2, '0');
    final minutes = time.minute.toString().padLeft(2, '0');
    List<Padding> list = [];
    final _controller = PageController();
    List<String> imageUrl;
    if(data.isNotEmpty){
    data.forEach((element) {
      imageUrl = element['imageURL'].split(',');
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
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          imageUrl[0].toString(),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
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
                                      element['actividad'],
                                      style: TextStyle(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF090F13),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    /*Text(
                                      '\$' + element['precio'].toString(),
                                      style: TextStyle(
                                        fontFamily: 'Outfit',
                                        color: Color.fromRGBO(101, 45, 143, 1),
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),*/
                                  ],
                                ),
                                Text(
                                  " ",
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    color: Color.fromRGBO(101, 45, 143, 1),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 4, 0, 0),
                                  child: Text(
                                    element['descripcion'],
                                    style: TextStyle(
                                      fontFamily: 'Outfit',
                                      color: Color(0xFF7C8791),
                                      fontSize: 14,
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
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(4, 0, 0, 0),
                                              child: Text(
                                                '4/5',
                                                style: TextStyle(
                                                  fontFamily: 'Outfit',
                                                  color: Color(0xFF101213),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(8, 0, 0, 0),
                                              child: Text(
                                                'Rating',
                                                style: TextStyle(
                                                  fontFamily: 'Outfit',
                                                  color: Color(0xFF57636C),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10, 0, 10, 0),
                                          child: SizedBox(
                                            width: 100,
                                            child: ElevatedButton(
                                              child: Text(
                                                "Ver Detalles",
                                                style: TextStyle(),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0.0,
                                                shadowColor: Colors.transparent,
                                                backgroundColor:
                                                    Color(0xFF652D8F),
                                                padding: EdgeInsets.zero,
                                              ),
                                              onPressed: () {
                                                GetListActivities(
                                                    widget.Ciudad,
                                                    widget.userloggeddata,
                                                    element['id'],
                                                    false,
                                                    widget.ActivitiesAdd);
                                              },
                                            ),
                                          )),
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
    });}else{
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
                      
                        Expanded(
                          flex: 6,
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(80, 0, 0, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "No existen registros.",
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    color: Colors.grey,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500,
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
    }

    return list;
  }

  @override
  void initState() {
    super.initState();
    //GetListHotels(widget.Ciudad,widget.userloggeddata);
    ListaHoteles = getHoteles();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    changeStatusColor(appStore.appBarColor);
    return MaterialApp(
        title: 'Flutter layout demo',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(65.0), // here the desired height
              child: AppBar(
                backgroundColor: Color.fromRGBO(101, 45, 143, 1),
                title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(125, 10, 0, 0),
                        child: Text("Actividades"),
                      ),
                      SizedBox.fromSize(
                        size: Size(80, 80), // button width and height
                        child: Material(
                          color:
                              Color.fromRGBO(101, 45, 143, 1), // button color
                          child: InkWell(
                            splashColor:
                                Color.fromRGBO(101, 45, 143, 1), // splash color
                            onTap: () {}, // button pressed
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                IconButton(
                                  icon: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1),
                                        shape: BoxShape.circle,
                                        color:
                                            Color.fromARGB(255, 210, 173, 238)),
                                    child: Center(
                                      child: Text(
                                        "${widget.ActivitiesAdd}",
                                        style: TextStyle(
                                            fontSize: 16, color: black),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (widget.ActivitiesAdd != 0) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HistoryActivities(
                                                    widget.userloggeddata,
                                                    widget.activityExtra,
                                                    widget.ActivitiesAdd,
                                                    widget.Ciudad,
                                                    widget.customPackage,
                                                    widget.CitiesDictionary)),
                                      );
                                    } else {
                                      showCupertinoDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              Theme(
                                                data: ThemeData.light(),
                                                child: CupertinoAlertDialog(
                                                  title: Text(
                                                    'Advertencia',
                                                    style: boldTextStyle(
                                                        color: Colors.black,
                                                        size: 18),
                                                  ),
                                                  content: Text(
                                                    'Seleccione una actividad',
                                                    style: secondaryTextStyle(
                                                        color: Colors.black,
                                                        size: 16),
                                                  ),
                                                  actions: [
                                                    CupertinoDialogAction(
                                                      child: Text(
                                                        'Aceptar',
                                                        style: primaryTextStyle(
                                                            color: redColor,
                                                            size: 18),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                    )
                                                  ],
                                                ),
                                              ));
                                    }
                                  },
                                ),
                                Text(
                                  "Ver Actividades",
                                  style: TextStyle(
                                      fontSize: 11.5, color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ]),
              ),
            ),
            body: SingleChildScrollView(
                // color:
                //     HotelAppTheme.buildLightTheme().backgroundColor,
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
                          children: ListActivities(snapshot.data, context));
                    } else {
                      return Center(
                          child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 350, 0, 0),
                        child: CircularProgressIndicator(
                            color: Color.fromARGB(255, 101, 45, 144)),
                      ));
                    }
                  },
                  future: GetListActivities(widget.Ciudad,
                      widget.userloggeddata, null, true, widget.ActivitiesAdd),
                ),
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
                          if (widget.activityExtra.isEmpty) {
                            showCupertinoDialog(
                                context: context,
                                builder: (BuildContext context) => Theme(
                                      data: ThemeData.light(),
                                      child: CupertinoAlertDialog(
                                        title: Text(
                                          'Advertencia\n',
                                          style: boldTextStyle(
                                              color: Colors.black, size: 18),
                                        ),
                                        content: Text(
                                          'No ha seleccionado ninguna actividad \n¿Está seguro de continuar?',
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
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        NavigationHomeScreen(
                                                            createCustomPackage(
                                                                widget.Ciudad,
                                                                widget
                                                                    .userloggeddata,
                                                                3,
                                                                widget
                                                                    .customPackage,
                                                                widget
                                                                    .CitiesDictionary),
                                                            widget
                                                                .userloggeddata)),
                                              );
                                            },
                                          )
                                        ],
                                      ),
                                    ));
                          } else {
                            widget.customPackage.actividadesExtra =
                                widget.activityExtra;
                            widget.customPackage.actividadesExtras =
                                jsonEncode(widget.activityExtra);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NavigationHomeScreen(
                                      createCustomPackage(
                                          widget.Ciudad,
                                          widget.userloggeddata,
                                          3,
                                          widget.customPackage,
                                          widget.CitiesDictionary),
                                      widget.userloggeddata)),
                            );
                          }
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
