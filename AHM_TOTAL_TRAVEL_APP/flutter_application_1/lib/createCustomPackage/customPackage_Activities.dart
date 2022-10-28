import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/ComponentsLogin/Decoder.dart';
import 'package:flutter_application_1/Models/HotelsViewModel.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;
import '../Models/CitiesViewModel.dart';
import '../Models/UsersViewModel.dart';
import '../utils/models.dart';
import '../utils/AppWidget.dart';
import '../utils/T2Colors.dart';
import '../utils/ListaHoteles.dart';
import '../utils/flutter_rating_bar.dart';
import 'package:http/http.dart';
import 'package:flutter_application_1/Components/http_client_default.dart' if (dart.library.html) 'http_client_browser.dart';

class customActivities extends StatefulWidget {
  static var tag = "/DemoT2Cards";
  final UserLoggedModel? userloggeddata;
  final CiudadesViewModel? Ciudad;

  const customActivities(this.userloggeddata, this.Ciudad, {super.key});
  @override
  _customActivities createState() => _customActivities();
}

  TimeOfDay time = TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
class _customActivities extends State<customActivities> {
  int ActivitiesCount = 0;


  late List<Hoteles> ListaHoteles;
  Map<int?, String> HotelsDictionary = Map();

  Future<dynamic> GetListActivities(Ciudad, userloggeddata) async {
    List<dynamic> dataActivities;
    String url_list =
        "https://totaltravelapi.azurewebsites.net/API/ActivitiesExtra/List";
    final headers = {
      "Content-type": "application/json",
      "Authorization": "bearer " + widget.userloggeddata!.Token!
    };
    final response = await http.get(Uri.parse(url_list), headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> userMap = jsonDecode(response.body);
      var Json = DecoderAPI.fromJson(userMap);
      dataActivities = Json.data;
      var activity =
          dataActivities.where((x) => x['ciudadID'] == Ciudad.ID).toList();

      return activity;
    } else {
       print(widget.userloggeddata!.Token);
          final url_list =Uri.parse("https://totaltravelapi.azurewebsites.net/API/Authentication/Refresh-token");
          final headers = {
            "Content-type": "application/json",
            "Authorization": "bearer " + widget.userloggeddata!.Token!
          };

            Future<Response> post(Uri url_list, {Map<String, String>? headers}) =>
            client.post(url_list, headers: headers);

            final clientReponse = client;

          final json = jsonEncode({"token": widget.userloggeddata!.Token});
          final response = await http.post(url_list, headers: headers, body: json);
          if (response.body != " ") {
            print(response.body);
            widget.userloggeddata!.Token = response.body;
            GetListActivities(Ciudad, widget.userloggeddata);
          }
    }
  }

  List<Padding> ListActivities(List<dynamic> data, BuildContext context) {
  final hours = time.hour.toString().padLeft(2,'0');
  final minutes = time.minute.toString().padLeft(2,'0');
    List<Padding> list = [];
    final _controller = PageController();
    List<String> imageUrl;
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
                                    Text(
                                      '\$' + element['precio'].toString(),
                                      style: TextStyle(
                                        fontFamily: 'Outfit',
                                        color: Color.fromRGBO(101, 45, 143, 1),
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
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
                                                "Reservar",
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
                                                showModalBottomSheet<void>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return Container(
                                                      height: 300,
                                                      color: Colors.white,
                                                      child: Center(
                                                        child: Column(
                                                          children: <Widget>[
                                                              Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          30,
                                                                          0,
                                                                          0),
                                                              child: Text(
                                                                "Seleccione una hora",
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Outfit',
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                            ),
                                                           Padding(padding: 
                                                           EdgeInsetsDirectional.fromSTEB(0, 10, 0, 20),
                                                           child: 
                                                            SizedBox(
                                                              width: 340,
                                                              height: 60,
                                                              child: ElevatedButton(
                                                              child: Text( '${hours}:${minutes}', style:  TextStyle(fontSize: 18, color: Color(0xFF652D8F))),
                                                              onPressed: () async{
                                                                TimeOfDay? newTime = 
                                                                await showTimePicker(
                                                                  cancelText: "Cancelar",
                                                                  confirmText: "Confirmar",
                                                                  context: context, 
                                                                  initialTime: time);

                                                                if(newTime == null) return;
                                                                setState(() => time = newTime);

                                                              },
                                                              style: ElevatedButton.styleFrom(
                                                                backgroundColor: Color.fromARGB(255, 234, 234, 234),
                                                              ),
                                                              ),
                                                            )
                                                           ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional .fromSTEB(0,0, 0,0),
                                                              child: Text(
                                                                "Personas",
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Outfit',
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsetsDirectional.fromSTEB(30, 0, 30, 20),
                                                              child: SpinBox(
                                                                max: 10,
                                                                value: 1,
                                                                onChanged:
                                                                    (value) {
                                                                  setState(
                                                                      () {});
                                                                },
                                                              ),
                                                             
                                                            ),
                                                             
                                                            Padding(padding: EdgeInsetsDirectional.fromSTEB(40, 0, 0, 0),
                                                            child: Row(
                                                              children: [
                                                                SizedBox(
                                                              width: 150,
                                                              height: 40,
                                                              child:
                                                                  ElevatedButton(
                                                                onPressed: () {
                                                                    print("aaaa");
                                                                },
                                                                child: Text(
                                                                  'Cancelar',
                                                                  style: TextStyle(
                                                                      fontSize:18, color:Color(
                                                                      0xFF652D8F) ),
                                                                ),
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  primary:Color.fromARGB(255, 234, 234, 234) ,
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                                              child: SizedBox(
                                                              width: 150,
                                                              height: 40,
                                                              child:
                                                                  ElevatedButton(
                                                                onPressed: () {
                                                                    print("aaaa");
                                                                },
                                                                child: Text(
                                                                  'Confirmar',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          18),
                                                                ),
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  primary: Color(
                                                                      0xFF652D8F),
                                                                ),
                                                              ),
                                                            ),
                                                            )
                                                            
                                                              ],
                                                            ),
                                                            )
                                                            

                                                            
                                                            
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
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
    });

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
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(101, 45, 143, 1),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(padding: EdgeInsetsDirectional.fromSTEB(120, 0, 0, 0),
                child:   Text("Actividades"),
                ),
                Padding(padding: EdgeInsetsDirectional.fromSTEB(57, 0, 0, 0),
                      child: Icon(
                    Icons.directions_run,
                    size: 30,
                    color: Color.fromARGB(255, 219, 195, 238),
                  ),
                ),
              IconButton(
                icon: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 210, 173, 238)
                  ),
              child: Center(
                child: Text( "${ActivitiesCount}", style: TextStyle(fontSize: 16, color: black),),
              ),
              ), onPressed: null)
            ]),
           
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
                    return Text(" ");
                  }
                },
                future: GetListActivities(widget.Ciudad, widget.userloggeddata),
              ),
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
