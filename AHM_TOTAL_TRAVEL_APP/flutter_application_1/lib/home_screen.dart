import 'dart:convert';

import 'package:flutter_application_1/hotel_booking/calendar_popup_view.dart';
import 'package:flutter_application_1/hotel_booking/hotel_list_view.dart';
import 'package:flutter_application_1/hotel_booking/model/hotel_list_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/AppWidget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/Components/Decodificador.dart';
import 'package:nb_utils/nb_utils.dart';
import 'DefaultPackageScreens/DetailsPackage.dart';
import 'Models/CitiesViewModel.dart';
import 'Models/DefaultPackageViewModel.dart';
import 'createCustomPackage/customPackage_Start.dart';
import 'hotel_booking/filters_screen.dart';
import 'hotel_booking/hotel_app_theme.dart';
import 'package:flutter_application_1/Components/Packages.dart';
import 'package:flutter_application_1/Models/UsersViewModel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_application_1/Components/Packages.dart';

import 'navigation_home_screen.dart';

class MyHomePage extends StatefulWidget {
  final UserLoggedModel? userloggeddata;
  const MyHomePage(this.userloggeddata, {Key? key}) : super(key: key);

  @override
  _HotelHomeScreenState createState() => _HotelHomeScreenState();
}

class _HotelHomeScreenState extends State<MyHomePage>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  List<HotelListData> hotelList = HotelListData.hotelList;
  final ScrollController _scrollController = ScrollController();

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));

  Map<int?, String> CitiesDictionary = Map();
  Future<dynamic> GetCities() async {
    var data;
    String url_list =
        "https://totaltravelapi.azurewebsites.net/API/Cities/List";
    var respuesta = await http.get(Uri.parse(url_list));
    if (respuesta.statusCode == 200) {
      Map<String, dynamic> ServerResponse = jsonDecode(respuesta.body);
      var Json = Decodificador.fromJson(ServerResponse);
      data = Json.data;
      // rellena diccionario de datos
      data.forEach((x) {
        CiudadesViewModel element = CiudadesViewModel.fromJson(x);
        var descripcion = element.Ciudad!;
        CitiesDictionary[element.ID] = descripcion;
      });

      return Json.data;
    } else {
      print("Error: " + respuesta.statusCode.toString());
    }
  }

  Future<dynamic> FindPackage(idPackage, userloggeddata) async {
    List<dynamic> datapackage;
    String urlList =
        "https://totaltravelapi.azurewebsites.net/API/DefaultPackages/List";
    final headers = {
      "Content-type": "application/json",
      "Authorization": "bearer " + userloggeddata!.Token!
    };
    final response = await http.get(Uri.parse(urlList), headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> userMap = jsonDecode(response.body);
      var Json = Decodificador.fromJson(userMap);
      datapackage = Json.data;
      var package = datapackage.where((x) => x['id'] == idPackage).toList();

      print(package);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailPackageScreen(userloggeddata, package)),
      );
    } else {
      print("Error " + response.statusCode.toString());
    }
  }

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
    GetCities();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: HotelAppTheme.buildLightTheme(),
      child: Container(
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Column(
                  children: <Widget>[
                    getAppBarUI(),
                    Expanded(
                      child: NestedScrollView(
                        controller: _scrollController,
                        headerSliverBuilder:
                            (BuildContext context, bool innerBoxIsScrolled) {
                          return <Widget>[
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                return Column(
                                  children: <Widget>[
                                    PaquetesPersoPromo(),
                                    // getTimeDateUI(),
                                  ],
                                );
                              }, childCount: 1),
                            ),
                          ];
                        },
                        body: SingleChildScrollView(
                            child: Column(
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: white,
                                ),
                                width: double.infinity,
                                height: 60,
                                padding: EdgeInsets.all(10),
                                child: Row(children: [
                                  Flexible(
                                      flex: 6,
                                      child: Text(
                                        " Mira a lo que te ofrecemos",
                                        style: TextStyle(
                                          fontFamily: 'Outfit',
                                          color: Color(0xFF090F13),
                                          fontSize: 22,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )),
                                  Divider(
                                    height: 1,
                                  )
                                ]),
                              ),
                            ),
                            FutureBuilder<dynamic>(
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Wrap(
                                      spacing: 8,
                                      runSpacing: 4,
                                      alignment: WrapAlignment.start,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.start,
                                      direction: Axis.horizontal,
                                      runAlignment: WrapAlignment.start,
                                      verticalDirection: VerticalDirection.down,
                                      clipBehavior: Clip.none,
                                      children: ListDefaultPackages(
                                          snapshot.data,
                                          context,
                                          widget.userloggeddata));
                                } else {
                                  return Center(
                                      child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 200, 0, 0),
                                    child: CircularProgressIndicator(
                                        color:
                                            Color.fromARGB(255, 101, 45, 144)),
                                  ));
                                }
                              },
                              future: GetListadoPackages(),
                            ),
                          ],
                        )),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getListUI() {
    return Container(
      decoration: BoxDecoration(
        color: HotelAppTheme.buildLightTheme().backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, -2),
              blurRadius: 8.0),
        ],
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height - 156 - 50,
            child: FutureBuilder<bool>(
              future: getData(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox();
                } else {
                  return ListView.builder(
                    itemCount: hotelList.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      final int count =
                          hotelList.length > 10 ? 10 : hotelList.length;
                      final Animation<double> animation =
                          Tween<double>(begin: 0.0, end: 1.0).animate(
                              CurvedAnimation(
                                  parent: animationController!,
                                  curve: Interval((1 / count) * index, 1.0,
                                      curve: Curves.fastOutSlowIn)));
                      animationController?.forward();

                      return HotelListView(
                        callback: () {},
                        hotelData: hotelList[index],
                        animation: animation,
                        animationController: animationController!,
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
                padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  child: ListTile(
                    onTap: () {},
                    title: const Text('Search'),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    selectedTileColor: Colors.grey[300],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.8),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 7), // changes position of shadow
                      ),
                    ],
                  ),
                )),
          ),
          Container(
            decoration: BoxDecoration(
              color: HotelAppTheme.buildLightTheme().primaryColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(38.0),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    offset: const Offset(0, 2),
                    blurRadius: 8.0),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.all(
                  Radius.circular(32.0),
                ),
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(FontAwesomeIcons.magnifyingGlass,
                      size: 20,
                      color: HotelAppTheme.buildLightTheme().backgroundColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showDemoDialog({BuildContext? context}) {
    showDialog<dynamic>(
      context: context!,
      builder: (BuildContext context) => CalendarPopupView(
        barrierDismissible: true,
        minimumDate: DateTime.now(),
        //  maximumDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 10),
        initialEndDate: endDate,
        initialStartDate: startDate,
        onApplyClick: (DateTime startData, DateTime endData) {
          setState(() {
            startDate = startData;
            endDate = endData;
          });
        },
        onCancelClick: () {},
      ),
    );
  }

  Widget PaquetesPersoPromo() {
    return Container(
      margin: EdgeInsets.all(12),
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          ClipRRect(
            child: Stack(
              children: <Widget>[
                Image.asset('assets/images/Argentina.jpg'),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(150, 0, 0, 0),
                  child: Container(
                    width: 125,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromRGBO(101, 45, 143, 1)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      child: Text(
                        'Personaliza',
                        style: TextStyle(
                          fontFamily: 'Outfit',
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NavigationHomeScreen(
                                  createPackage(
                                      widget.userloggeddata, CitiesDictionary),
                                  widget.userloggeddata)),
                        );
                      },
                    ),
                    decoration:
                        BoxDecoration(shape: BoxShape.circle, color: white),
                  ),
                ),
              ],
              alignment: Alignment.center,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: Column(children: [
                        Text(
                          "Crea tu Propio paquete para disfrutar a tu manera",
                          style: TextStyle(
                              color: black,
                              fontSize: 18,
                              fontFamily: 'Outfit',
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Te damos la oportunidad de crear tu propia aventura a tu manera en los mejores lugares de tu preferencia",
                          style: TextStyle(
                              color: grey,
                              fontSize: 14,
                              fontFamily: 'Outfit',
                              fontWeight: FontWeight.w400),
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[Icon(Icons.favorite)],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: HotelAppTheme.buildLightTheme().primaryColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 8.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
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
                  ' ',
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
    );
  }
}

class ContestTabHeader extends SliverPersistentHeaderDelegate {
  ContestTabHeader(
    this.searchUI,
  );
  final Widget searchUI;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return searchUI;
  }

  @override
  double get maxExtent => 52.0;

  @override
  double get minExtent => 52.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
