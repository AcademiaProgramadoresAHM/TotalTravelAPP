// @dart=2.18
import 'dart:io';
import 'package:flutter_application_1/Screens/LandingPage.dart';
import 'package:flutter_application_1/models/Total_travel_action.dart';
import 'package:flutter_application_1/services/Notification_action_services.dart';

import 'package:flutter_application_1/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'navigation_home_screen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_application_1/Screens/Login.dart';

final navigatorKey = GlobalKey<NavigatorState>();
final notificationActionService = NotificationActionService();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  notificationActionService.actionTriggered.listen((event) {
    notificationActionTriggered(event as TotalTravelAction);
  });
  await notificationActionService.checkLaunchAction();
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) =>
      runApp(MaterialApp(home: LandingPage(), navigatorKey: navigatorKey)));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
          !kIsWeb && Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      title: 'Flutter UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        textTheme: AppTheme.textTheme,
        platform: TargetPlatform.iOS,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: LandingPage(),
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}

void notificationActionTriggered(TotalTravelAction action) {
  // showActionAlert(
  //     message: "${action.toString().split(".")[1]} action received");
  print("${action.toString().split(".")[1]} action received");
}

// Future<void> showActionAlert({message: String}) async {
//   return showDialog<void>(
//     context: navigatorKey.currentState!.overlay!.context,
//     barrierDismissible: false,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text('Total Travel'),
//         content: SingleChildScrollView(
//           child: ListBody(
//             children: <Widget>[
//               Text(message),
//             ],
//           ),
//         ),
//         actions: <Widget>[
//           ElevatedButton(
//             child: Text('Ok'),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         ],
//       );
//     },
//   );
// }
