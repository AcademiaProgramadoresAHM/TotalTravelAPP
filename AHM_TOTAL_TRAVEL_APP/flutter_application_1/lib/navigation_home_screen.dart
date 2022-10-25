import 'package:flutter_application_1/Account_screen.dart';
import 'package:flutter_application_1/Screens/Compras.dart';
import 'package:flutter_application_1/createCustomPackage/customPackage_Start.dart';
import 'package:flutter_application_1/Screens/historialcompras.dart';
import 'package:flutter_application_1/Support_Screen.dart';
import 'package:flutter_application_1/app_theme.dart';
import 'package:flutter_application_1/custom_drawer/drawer_user_controller.dart';
import 'package:flutter_application_1/custom_drawer/home_drawer.dart';
import 'package:flutter_application_1/feedback_screen.dart';
import 'package:flutter_application_1/help_screen.dart';
import 'package:flutter_application_1/home_screen.dart';
import 'package:flutter_application_1/invite_friend_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/historial_transacciones.dart';
import 'package:flutter_application_1/Models/UsersViewModel.dart';

import 'Screens/Personalizados.dart';
import 'main.dart';

class NavigationHomeScreen extends StatefulWidget {
  final UserLoggedModel? userloggeddata;
  const NavigationHomeScreen(this.userloggeddata, {Key? key}) : super(key: key);

  @override
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget? screenView;
  DrawerIndex? drawerIndex;
  UserLoggedModel? userloggeddata;

  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    screenView = const MyHomePage();
    super.initState();
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
            screenView = const MyHomePage();
          });
          break;
        case DrawerIndex.Help:
          setState(() {
            screenView = Comprashistorial(widget.userloggeddata);
          });
          break;
        case DrawerIndex.FeedBack:
          setState(() {
            screenView = FeedbackScreen();
          });
          break;
        case DrawerIndex.Compras:
          setState(() {
            screenView = Compras();
          });
          break;
        case DrawerIndex.CrearPaquete:
          setState(() {
            screenView = createPackage(widget.userloggeddata);
          });
          break;
        case DrawerIndex.Account:
          setState(() {
            screenView = AccountInfo(widget.userloggeddata);
          });
          break;
        case DrawerIndex.Personalization:
          setState(() {
            screenView = PersonaliScreen();
          });
          break;
        case DrawerIndex.Historial:
          setState(() {
            screenView = HistorialScreen(widget.userloggeddata);
          });
          break;
        case DrawerIndex.Support:
          setState(() {
            screenView = SupportScreen();
          });
          break;
        default:
          break;
      }
    }
  }
}
