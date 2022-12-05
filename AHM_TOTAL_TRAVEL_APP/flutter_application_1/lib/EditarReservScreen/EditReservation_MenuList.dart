import 'package:flutter/material.dart';

import '../Components/Decodificador.dart';
import '../Models/ReservationViewModel.dart';
import '../Models/UsersViewModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditReservationMenuList extends StatefulWidget {
  final ReservEdit reservacionEditado;
  final List<dynamic> reservationList;
  final UserLoggedModel? userloggeddata;
  final List<dynamic> Menu;
  final String Restaurante;
  EditReservationMenuList(this.userloggeddata, this.reservacionEditado,
      this.reservationList, this.Menu, this.Restaurante);
  @override
  State<EditReservationMenuList> createState() => _MyAppState();
}

class _MyAppState extends State<EditReservationMenuList> {
  Future<dynamic> GetListadoRestauranteEdit() async {
    String url_list =
        "https://totaltravelapi.azurewebsites.net/API/Restaurants/List";
    final response = await http.get(Uri.parse(url_list));
    if (response.statusCode == 200) {
      Map<String, dynamic> userMap = jsonDecode(response.body);
      var user = Decodificador.fromJson(userMap);
      return user.data;
    } else {
      print("Error " + response.statusCode.toString());
    }
  }

  List<Padding> ListMenus(List<dynamic> data, BuildContext context) {
    List<Padding> list = [];
    final _controller = PageController();
    List<String> imageUrl;
    data.forEach((element) {
      imageUrl = element['image_Url'].split(',');
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
                      height: 150,
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
                                    Text(
                                      element['menu'],
                                      style: TextStyle(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF090F13),
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
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
                                      200, 8, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "HNL " +
                                            element['precio'].toString() +
                                            '0',
                                        style: TextStyle(
                                          fontFamily: 'Outfit',
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter layout demo',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF652D8F),
            automaticallyImplyLeading: false,
            title: Row(children: <Widget>[
              Material(
                color: Color.fromRGBO(101, 45, 143, 1), // button color
                child: InkWell(
                  splashColor: Color.fromRGBO(101, 45, 143, 1), // splash color
                  onTap: () {}, // button pressed
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(75, 0, 0, 0),
                child: Text(widget.Restaurante.toString()),
              ),
            ]),
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
              FutureBuilder<dynamic>(
                builder: (context, snapshot) {
                  if (widget.Menu.isNotEmpty) {
                    return Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        alignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        direction: Axis.horizontal,
                        runAlignment: WrapAlignment.start,
                        verticalDirection: VerticalDirection.down,
                        clipBehavior: Clip.none,
                        children: ListMenus(widget.Menu, context));
                  } else {
                    return Center(
                        child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 350, 0, 0),
                      child: CircularProgressIndicator(
                          color: Color.fromARGB(255, 101, 45, 144)),
                    ));
                  }
                },
              ),
            ],
          )),
        ));
  }
}
