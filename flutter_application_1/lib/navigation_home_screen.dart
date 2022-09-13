import 'package:flutter_application_1/Account_screen.dart';
import 'package:flutter_application_1/Screens/Compras.dart';
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

class NavigationHomeScreen extends StatefulWidget {
  @override
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget? screenView;
  DrawerIndex? drawerIndex;

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
            screenView = HelpScreen();
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
        case DrawerIndex.Invite:
          setState(() {
            screenView = InviteFriend();
          });
          break;
        case DrawerIndex.Account:
          setState(() {
            screenView = AccountInfo();
          });
          break;
        case DrawerIndex.Historial:
          setState(() {
            screenView = HistorialScreen();
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
