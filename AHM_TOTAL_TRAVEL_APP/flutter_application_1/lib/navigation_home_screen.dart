import 'dart:convert';

import 'package:flutter_application_1/Account_screen.dart';
import 'package:flutter_application_1/ComponentsLogin/Decoder.dart';
import 'package:flutter_application_1/Models/CitiesViewModel.dart';
import 'package:flutter_application_1/Screens/Compras.dart';
import 'package:flutter_application_1/createCustomPackage/customPackage_Start.dart';
import 'package:flutter_application_1/Screens/historialcompras.dart';
import 'package:flutter_application_1/Support_Screen.dart';
import 'package:flutter_application_1/app_theme.dart';
import 'package:flutter_application_1/custom_drawer/drawer_user_controller.dart';
import 'package:flutter_application_1/custom_drawer/home_drawer.dart';
import 'package:flutter_application_1/feedback_screen.dart';
import 'package:flutter_application_1/home_screen.dart';
import 'package:flutter_application_1/invite_friend_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/historial_transacciones.dart';
import 'package:flutter_application_1/Models/UsersViewModel.dart';
import 'package:http/http.dart' as http;

import 'Components/Decodificador.dart';
import 'Screens/Personalizados.dart';
import 'main.dart';

class NavigationHomeScreen extends StatefulWidget {
  final UserLoggedModel? userloggeddata;
  final Widget page;
  const NavigationHomeScreen(this.page, this.userloggeddata, {Key? key})
      : super(key: key);

  @override
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget? screenView;
  DrawerIndex? drawerIndex;
  UserLoggedModel? userloggeddata;

  Future<dynamic> FindReservation(userloggeddata) async {
    List<dynamic> datapackage;
    String url_list =
        "https://apitotaltravel.azurewebsites.net/API/Reservation/List";
    final headers = {
      "Content-type": "application/json",
      "Authorization": "bearer " + widget.userloggeddata!.Token!
    };
    final response = await http.get(Uri.parse(url_list), headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> userMap = jsonDecode(response.body);
      var Json = Decodificador.fromJson(userMap);
      datapackage = Json.data;
      var package =
          datapackage.where((x) => x['id'] == userloggeddata.id).toList();

      print(package);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PersonaliScreen(widget.userloggeddata)),
      );
    } else {
      print("Error " + response.statusCode.toString());
    }
  }

  Future<dynamic> FindShoppingHistory(userloggeddata) async {
    List<dynamic> dataShoppingHistory;
    String url_list =
        "https://apitotaltravel.azurewebsites.net/API/RecordPayment/List";
    final headers = {
      "Content-type": "application/json",
      "Authorization": "bearer " + widget.userloggeddata!.Token!
    };
    final response = await http.get(Uri.parse(url_list), headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> userMap = jsonDecode(response.body);
      var Json = Decodificador.fromJson(userMap);
      dataShoppingHistory = Json.data;
      var ShoppingHistory = dataShoppingHistory
          .where((x) => x['id'] == userloggeddata.id)
          .toList();

      print(ShoppingHistory);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Comprashistorial(widget.userloggeddata)));
    } else {
      print("Error " + response.statusCode.toString());
    }
  }

  Future<dynamic> FindPaymentHistory(idPaymentHistory, userloggeddata) async {
    List<dynamic> dataShoppingHistory;
    String url_list =
        "https://apitotaltravel.azurewebsites.net/API/RecordPayment/List";
    final headers = {
      "Content-type": "application/json",
      "Authorization": "bearer " + widget.userloggeddata!.Token!
    };
    final response = await http.get(Uri.parse(url_list), headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> userMap = jsonDecode(response.body);
      var Json = Decodificador.fromJson(userMap);
      dataShoppingHistory = Json.data;
      var ShoppingHistory = dataShoppingHistory
          .where((x) => x['id'] == idPaymentHistory)
          .toList();

      print(ShoppingHistory);
      // Navigator.push(
      //   context,
      ///  MaterialPageRoute(
      //    builder: (context) =>
      //       HistorydetailScreen(widget.userloggeddata, ShoppingHistory)));
    } else {
      print("Error " + response.statusCode.toString());
    }
  }

  Map<int?, String> CitiesDictionary = Map();

  Future<dynamic> GetCities() async {
    var data;
    String url_list =
        "https://apitotaltravel.azurewebsites.net/API/Cities/List";
    var respuesta = await http.get(Uri.parse(url_list));
    if (respuesta.statusCode == 200) {
      Map<String, dynamic> ServerResponse = jsonDecode(respuesta.body);
      var Json = DecoderAPI.fromJson(ServerResponse);
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

  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    screenView = widget.page;
    super.initState();
    GetCities();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.white,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: DrawerUserController(
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (DrawerIndex drawerIndexdata) {
              changeIndex(drawerIndexdata);
              //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
            },
            screenView: screenView,
            userloggeddata: widget.userloggeddata,
            //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      switch (drawerIndex) {
        case DrawerIndex.HOME:
          setState(() {
            screenView = MyHomePage(widget.userloggeddata);
          });
          break;
        case DrawerIndex.FeedBack:
          setState(() {
            screenView = FeedbackScreen(widget.userloggeddata);
          });
          break;
        case DrawerIndex.CrearPaquete:
          setState(() {
            screenView = createPackage(widget.userloggeddata, CitiesDictionary);
          });
          break;
        case DrawerIndex.Personalization:
          setState(() {
            screenView = PersonaliScreen(widget.userloggeddata);
          });
          break;
        case DrawerIndex.Help:
          setState(() {
            screenView = Comprashistorial(widget.userloggeddata);
          });
          break;

        case DrawerIndex.Account:
          setState(() {
            screenView = AccountInfo(widget.userloggeddata);
          });
          break;

        case DrawerIndex.Historial:
          setState(() {
            screenView = HistorialScreen(widget.userloggeddata);
          });
          break;
        case DrawerIndex.Support:
          setState(() {
            screenView = SupportScreen(widget.userloggeddata);
          });
          break;
        default:
          break;
      }
    }
  }
}
