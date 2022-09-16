import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/Lipsum.dart' as lipsum;
import 'package:nb_utils/nb_utils.dart'; //https://pub.dev/packages/nb_utils

class Transportes extends StatefulWidget {
  static String tag = '/DemoCWSegmentedControlScreen';

  @override
  DemoCWSegmentedControlScreenState createState() =>
      DemoCWSegmentedControlScreenState();
}

class DemoCWSegmentedControlScreenState extends State<Transportes> {
  int selectedValue = 0;

  final Map<int, Widget> sWidget = <int, Widget>{
    0: Text("Home", style: primaryTextStyle()),
    1: Text("Search", style: primaryTextStyle()),
    2: Text("Profile", style: primaryTextStyle())
  };

  static Widget giveCenter(String yourText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        12.height,
        Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 8),
          child: (
            lipsum.Trans()
          ),
        ),
      ],
    );
  }

  List<Widget> view = [
    giveCenter("Terrestre"),
    giveCenter("Marítimo"),
    giveCenter("Aereo")
  ];

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
    final Map<int, Widget> sWidget = <int, Widget>{
      0: Text("Terrestre",
          style: primaryTextStyle(
              color: selectedValue == 0 ? white : appStore.textPrimaryColor)),
      1: Text("Marítimo",
          style: primaryTextStyle(
              color: selectedValue == 1 ? white : appStore.textPrimaryColor)),
      2: Text("Aereo",
          style: primaryTextStyle(
              color: selectedValue == 2 ? white : appStore.textPrimaryColor))
    };

    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          16.height,
          Container(
            color: appStore.appBarColor,
            width: context.width(),
            child: CupertinoSegmentedControl(
              borderColor: appStore.appColorPrimary,
              selectedColor: appStore.appColorPrimary,
              groupValue: selectedValue,
              onValueChanged: (dynamic val) {
                setState(() {
                  selectedValue = val;
                });
              },
              children: sWidget,
            ),
          ),
          8.height,
          view[selectedValue]
        ],
      )),
    );
  }
}

AppStore appStore = AppStore();

class AppStore {
  Color textPrimaryColor = Color(0xFF212121);
  Color iconColorPrimaryDark = Color(0xFF212121);
  Color scaffoldBackground = Color(0xFFEBF2F7);
  Color backgroundColor = Colors.black;
  Color backgroundSecondaryColor = Color(0xFF131d25);
  Color appColorPrimaryLightColor = Color(0xFFF9FAFF);
  Color textSecondaryColor = Color(0xFF5A5C5E);
  Color appBarColor = Colors.white;
  Color iconColor = Color(0xFF212121);
  Color iconSecondaryColor = Color(0xFFA8ABAD);
  Color cardColor = Colors.white;
  Color appColorPrimary = Color.fromARGB(255, 101, 45, 143);
  Color scaffoldBackgroundColor = Color(0xFFEFEFEF);

  AppStore();
}
