import 'package:flutter_application_1/Models/UsersViewModel.dart';
import 'package:flutter_application_1/Screens/Login.dart';
import 'package:flutter_application_1/app_theme.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({
    Key? key,
    this.screenIndex,
    this.iconAnimationController,
    this.callBackIndex,
    this.userloggeddata,
  }) : super(key: key);

  final UserLoggedModel? userloggeddata;
  final AnimationController? iconAnimationController;
  final DrawerIndex? screenIndex;
  final Function(DrawerIndex)? callBackIndex;

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  UserLoggedModel? userloggeddata;
  List<DrawerList>? drawerList;

  var _userData;
  String? name;

  @override
  void initState() {
    setDrawerListArray();
    super.initState();
    GetUserData();
  }

  Future<void> GetUserData() async {
    String url_list =
        "https://totaltravelapi.azurewebsites.net/API/Users/Find?id=" +
            widget.userloggeddata!.ID.toString();
    final headers = {
      "Content-type": "application/json",
      "Authorization": "bearer " + widget.userloggeddata!.Token!
    };
    final respuesta = await http.get(Uri.parse(url_list), headers: headers);
    if (respuesta.statusCode == 200) {
      Map<String, dynamic> userMap = jsonDecode(respuesta.body);
      var data = userMap['data'];
      setState(() {
        _userData = data;
        name = _userData['nombre'] + ' ' + _userData['apellido'];
      });
    } else {
      print("Error: " + respuesta.statusCode.toString());
    }
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  void setDrawerListArray() {
    drawerList = <DrawerList>[
      DrawerList(
        index: DrawerIndex.HOME,
        labelName: 'Inicio',
        icon: Icon(Icons.home),
      ),
      DrawerList(
          index: DrawerIndex.Help,
          labelName: 'Historial de compra',
          icon: Icon(Icons.history)),
      DrawerList(
        index: DrawerIndex.FeedBack,
        labelName: 'Ofertas de viaje',
        icon: Icon(Icons.loyalty),
      ),
      DrawerList(
        index: DrawerIndex.CrearPaquete,
        labelName: 'Haz tu propio paquete',
        icon: Icon(Icons.new_label),
      ),
      DrawerList(
        index: DrawerIndex.Historial,
        labelName: 'Historial de transacciones',
        icon: Icon(Icons.history),
      ),
      /*DrawerList(
        index: DrawerIndex.Compras,
        labelName: 'Compras',
        icon: Icon(Icons.shopping_cart),
      ),*/
      DrawerList(
        index: DrawerIndex.Account,
        labelName: 'Mi Cuenta',
        icon: Icon(Icons.person),
      ),
      DrawerList(
        index: DrawerIndex.Personalization,
        labelName: 'Reservaciones',
        icon: Icon(Icons.list),
      ),
      DrawerList(
        index: DrawerIndex.Support,
        labelName: 'Contactanos',
        icon: Icon(Icons.info),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return Scaffold(
      backgroundColor: AppTheme.notWhite.withOpacity(0.5),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 40.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  AnimatedBuilder(
                    animation: widget.iconAnimationController!,
                    builder: (BuildContext context, Widget? child) {
                      return ScaleTransition(
                        scale: AlwaysStoppedAnimation<double>(1.0 -
                            (widget.iconAnimationController!.value) * 0.2),
                        child: RotationTransition(
                          turns: AlwaysStoppedAnimation<double>(Tween<double>(
                                      begin: 0.0, end: 24.0)
                                  .animate(CurvedAnimation(
                                      parent: widget.iconAnimationController!,
                                      curve: Curves.fastOutSlowIn))
                                  .value /
                              360),
                          child: Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: HexColor('#652D90'),
                                    offset: const Offset(2.0, 4.0),
                                    blurRadius: 8),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(60.0)),
                              child: Image.network(_userData['image_URL']),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 4),
                    child: Text(
                      name ?? 'nulo',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: HexColor('#652D90'),
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Divider(
            height: 1,
            color: HexColor('#652D90'),
          ),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(0.0),
              itemCount: drawerList?.length,
              itemBuilder: (BuildContext context, int index) {
                return inkwell(drawerList![index]);
              },
            ),
          ),
          Divider(
            height: 1,
            color: HexColor('#652D90'),
          ),
          Column(
            children: <Widget>[
              ListTile(
                title: Text(
                  'Cerrar sesión',
                  style: TextStyle(
                    fontFamily: AppTheme.fontName,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: HexColor('#652D90'),
                  ),
                  textAlign: TextAlign.left,
                ),
                trailing: Icon(
                  Icons.power_settings_new,
                  color: Colors.red,
                ),
                onTap: () {
                  showCupertinoDialog(
                      context: context,
                      builder: (BuildContext context) => Theme(
                            data: ThemeData.light(),
                            child: CupertinoAlertDialog(
                              title: Text(
                                'Cerrar Sesión?',
                                style: boldTextStyle(
                                    color: Colors.black, size: 18),
                              ),
                              content: Text(
                                'Seguro de Cerrar la Sesión?',
                                style: secondaryTextStyle(
                                    color: Colors.black, size: 16),
                              ),
                              actions: [
                                CupertinoDialogAction(
                                  child: Text(
                                    'Cancel',
                                    style: primaryTextStyle(
                                        color: dodgerBlue, size: 18),
                                  ),
                                  onPressed: () {
                                    toasty(context, 'Cancel');
                                    finish(context);
                                  },
                                ),
                                CupertinoDialogAction(
                                  child: Text(
                                    'Cerrar Sesión',
                                    style: primaryTextStyle(
                                        color: redColor, size: 18),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Login()),
                                    );
                                  },
                                )
                              ],
                            ),
                          ));
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom,
              )
            ],
          ),
        ],
      ),
    );
  }

  void onTapped() {
    print('Doing Something...'); // Print to console.
  }

  Widget inkwell(DrawerList listData) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.grey.withOpacity(0.1),
        highlightColor: Colors.transparent,
        onTap: () {
          navigationtoScreen(listData.index!);
        },
        child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 6.0,
                    height: 46.0,
                    // decoration: BoxDecoration(
                    //   color: widget.screenIndex == listData.index
                    //       ? Colors.blue
                    //       : Colors.transparent,
                    //   borderRadius: new BorderRadius.only(
                    //     topLeft: Radius.circular(0),
                    //     topRight: Radius.circular(16),
                    //     bottomLeft: Radius.circular(0),
                    //     bottomRight: Radius.circular(16),
                    //   ),
                    // ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  listData.isAssetsImage
                      ? Container(
                          width: 24,
                          height: 24,
                          child: Image.asset(listData.imageName,
                              color: widget.screenIndex == listData.index
                                  ? HexColor('#652D90')
                                  : AppTheme.nearlyBlack),
                        )
                      : Icon(listData.icon?.icon,
                          color: widget.screenIndex == listData.index
                              ? HexColor('#652D90')
                              : AppTheme.nearlyBlack),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  Text(
                    listData.labelName,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: widget.screenIndex == listData.index
                          ? Colors.black
                          : AppTheme.nearlyBlack,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            widget.screenIndex == listData.index
                ? AnimatedBuilder(
                    animation: widget.iconAnimationController!,
                    builder: (BuildContext context, Widget? child) {
                      return Transform(
                        transform: Matrix4.translationValues(
                            (MediaQuery.of(context).size.width * 0.75 - 64) *
                                (1.0 -
                                    widget.iconAnimationController!.value -
                                    1.0),
                            0.0,
                            0.0),
                        child: Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 8),
                          child: Container(
                            width:
                                MediaQuery.of(context).size.width * 0.75 - 64,
                            height: 46,
                            decoration: BoxDecoration(
                              color: HexColor('#652D90').withOpacity(0.2),
                              borderRadius: new BorderRadius.only(
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(28),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(28),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }

  Future<void> navigationtoScreen(DrawerIndex indexScreen) async {
    widget.callBackIndex!(indexScreen);
  }
}

enum DrawerIndex {
  HOME,
  FeedBack,
  Help,
  Share,
  /* Compras,*/
  CrearPaquete,
  Testing,
  Account,
  Historial,
  Personalization,
  Support
}

class DrawerList {
  DrawerList({
    this.isAssetsImage = false,
    this.labelName = '',
    this.icon,
    this.index,
    this.imageName = '',
  });

  String labelName;
  Icon? icon;
  bool isAssetsImage;
  String imageName;
  DrawerIndex? index;
}
