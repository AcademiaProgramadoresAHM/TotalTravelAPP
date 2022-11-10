import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Components/CardTimeline.dart';
import 'package:flutter_application_1/Components/Decodificador.dart';
import 'package:flutter_application_1/ComponentsLogin/controller/simple_ui_controller.dart';
import 'package:flutter_application_1/Models/TimelineViewModel.dart';
import 'package:flutter_application_1/Models/UsersViewModel.dart';
import 'package:flutter_application_1/hotel_booking/hotel_app_theme.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/navigation_home_screen.dart';
//import 'package:percent_indicator/percent_iimport ';
import '../utils/T7Colors.dart';
import 'package:intl/intl.dart';

class Timeline extends StatefulWidget {
  final UserLoggedModel? userloggeddata;
  final List<dynamic> Reservation;
  const Timeline(this.userloggeddata, this.Reservation, {Key? key}) : super(key: key);

  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  SimpleUIController simpleUIController = Get.put(SimpleUIController());
  List<Color> colors = [Colors.red, Colors.green,Colors.pinkAccent, Colors.blue];


  Future<dynamic> GetListTimelineReservation(idReservation, userloggeddata) async {
    List<dynamic> dataReservation;
    TimelineViewModel timelineViewModel;
    String url_list =
        "https://totaltravelapi.azurewebsites.net/API/Reservation/Find/Timeline?id=" + idReservation.toString();
    final headers = {
      "Content-type": "application/json",
      "Authorization": "bearer " + widget.userloggeddata!.Token!
    };
    final response = await http.get(Uri.parse(url_list), headers: headers);
    print("Este es el response: " + response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> userMap = jsonDecode(response.body);
      var Json = Decodificador.fromJson(userMap);
      dataReservation = Json.data;
      print(dataReservation.toString());
      timelineViewModel = TimelineViewModel.fromJson(dataReservation[0]);
      print(timelineViewModel);
      return dataReservation;
    } else {
      print("Error " + response.statusCode.toString());
    }
  }


  List<ProcessCard> _getProcess(){
    List<ProcessCard> processCard = [];

    processCard.add(ProcessCard("Punto de Transporte", "20 de septiembre del 2022, se abordará en los servicios de Los Bobinos a las 16:00 y llegara a su destino a las 21:00", Icons.adjust_rounded));
    processCard.add(ProcessCard("Llegada al hotel", "20 de septiembre de 2022, Se alojara en el hotel Hyatt Place", Icons.check));
    processCard.add(ProcessCard("Actividades", "25 de septiembre de 2022, surfear con pirañas", Icons.border_color_rounded));
    processCard.add(ProcessCard("Actividades", "29 de septiembre de 2022, saltar de un avion y surfear con pirañas", Icons.call_merge_rounded));
    processCard.add(ProcessCard("Final del viaje", "30 de septiembre de 2022, desalojara el hotel Hyatt Place", Icons.change_circle_rounded));
    return processCard;
  }

  List<ProcessCard> processCard = [];

  @override
  void initState() {
    super.initState();
    processCard = _getProcess();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    print("hola");
    GetListTimelineReservation(widget.Reservation, widget.userloggeddata);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          appBar: AppBar(
            title: Text('        Linea de Tiempo'),
            backgroundColor: Color.fromRGBO(101, 45, 143, 1),
          ),
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          body: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                return _buildLargeScreen(size, simpleUIController, theme);
              } else {
                return _buildSmallScreen(size, simpleUIController, theme);
              }
            },
          )),
    );
  }

  Widget _buildLargeScreen(
      Size size, SimpleUIController simpleUIController, ThemeData theme) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: RotatedBox(
            quarterTurns: 3,
          ),
        ),
        SizedBox(width: size.width * 0.06),
        Expanded(
          flex: 5,
          child: _buildMainBody(size, simpleUIController, theme),
        ),
      ],
    );
  }

  /// For Small screens
  Widget _buildSmallScreen(
      Size size, SimpleUIController simpleUIController, ThemeData theme) {
    return Center(
      child: _buildMainBody(size, simpleUIController, theme),
    );
  }

  Widget _buildMainBody(
      Size size, SimpleUIController simpleUIController, ThemeData theme) {
    return Theme(
        data: HotelAppTheme.buildLightTheme(),
          child: Container(
            child: Scaffold(
              body: Container(
                child: ListView.builder(
                  itemCount: processCard.length,
                  itemBuilder: (context, index) {
            return Container(child: Row(
              children: <Widget>[
                Column(children: <Widget>[
                  Container(
                    width: 2,
                    height: 60,
                    color: index == 0 ? Colors.white : Colors.black,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 8, right: 5),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: colors[(index + 1) % 4],
                        borderRadius: BorderRadius.circular(50)
                    ),
                    child: Icon(processCard[index].icon, color: Colors.white,),
                  ),
                  Container(
                    width: 2,
                    height: 60,
                    color: index == processCard.length - 1
                        ? Colors.white
                        : Colors.black,
                  ),
                ],
                ),
                Expanded(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            top: BorderSide(width: 3, color: colors[(index +
                                1) % 4],),
                            left: BorderSide(width: 3, color: colors[(index +
                                1) % 4],),),
                          boxShadow: [BoxShadow(
                            blurRadius: 5,
                            color: Colors.black26,
                          )
                          ]
                      ),
                      height: 140,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(processCard[index].title, style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: colors[(index + 1) % 4],),),
                            Text(processCard[index].description,
                              style: TextStyle(fontSize: 17, letterSpacing: 2),)
                          ],
                        ),
                      ),
                    ))
              ],
            ),

            );
          }),
          )
        )
        )
    );
  }
}