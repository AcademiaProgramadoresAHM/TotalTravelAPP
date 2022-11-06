import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/AppWidget.dart';
import 'package:flutter_application_1/utils/prueba2/T2Colors.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_application_1/Components/Packages.dart';
import 'package:flutter_application_1/Components/Decodificador.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_application_1/hotel_booking/hotel_app_theme.dart';
import 'package:flutter_application_1/hotel_booking/model/PlanModal.dart';
import 'package:flutter_application_1/Screens/Login.dart';
import 'package:flutter_application_1/Screens/signUp_view.dart';
import 'package:flutter_application_1/services/Notification_registration_services.dart';
import 'package:flutter_application_1/config.dart';

final notificationRegistrationService =
    NotificationRegistrationService(Config.backendServiceEndpoint);

class LandingPage extends StatefulWidget {
  @override
  LandingPageState createState() => LandingPageState();
}

class LandingPageState extends State<LandingPage> {


  List<PlanModal> planList = [];
  PageController controller =
      PageController(initialPage: 0, viewportFraction: 0.85);
  int selectedIndex = 0;
  int pageIndex = 0;
  Color blueButtonAndTextColor = Color.fromARGB(255, 101, 45, 144);

  List<Container> LandScreenPackage(List<dynamic> data, BuildContext context) {
    registerButtonClicked();
    List<PlanModal> PlanList = [];
    List<Container> list = [];
    final _controller = PageController();
    data.forEach((element) {
      list.add(
        Container(
          height: 650,
          width: context.width(),
          child: Container(
            height: 650,
            child: Container(
              height: 650,
              width: context.width(),
              decoration: BoxDecoration(
                color: context.cardColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: defaultBoxShadow(),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    'assets/images/Argentina.jpg',
                    fit: BoxFit.cover,
                    height: 170,
                  ),
                  SizedBox(height: 20),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        //ElevatedButton(
                        //child: Text("Register"),
                        //onPressed: registerButtonClicked,
                        //),
                        /*
                        ElevatedButton(
                          child: Text("Deregister"),
                          onPressed: deregisterButtonClicked,
                        ),*/
                        Text(element['nombre'], style: boldTextStyle(size: 30)),
                        Text(
                            element['descripcion_Paquete'] ??
                                'No descripcion Disponible',
                            style: secondaryTextStyle()),
                        24.height,
                        Text('\$' + element['precio'].toString(),
                            style: boldTextStyle(
                                size: 45, color: blueButtonAndTextColor)),
                        Text('per user/month', style: secondaryTextStyle()),
                        24.height,
                        Container(
                          height: 200,
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: UL(
                              symbolType: SymbolType.Bullet,
                              symbolColor: Color.fromARGB(255, 101, 45, 144),
                              spacing: 24,
                              children: [
                                Text(
                                    element['hotel'] ??
                                        'No hay Hoteles Disponibles',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                                Text(
                                    element['restaurante'] ??
                                        'No hay Restaurantes Disponibles',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                                Text(
                                    element['duracion_Paquete'] ??
                                        'No Disponibles',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                              ]),
                        ),
                      ],
                    ),
                  ).expand(),
                  AppButton(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          width: context.width() - 120,
                          child: Text(
                            'Adquirir paquete',
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 80, 28, 111)),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()));
                          },
                          shapeBorder: RoundedRectangleBorder(
                              borderRadius: radius(defaultRadius)),
                          color: Color.fromARGB(255, 249, 233, 255))
                      .paddingBottom(16),
                ],
              ),
            ),
          ),
        ),
      );
    });
    return list;
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void registerButtonClicked() async {
    try {
      await notificationRegistrationService.registerDevice([]);
      //await showAlert(message: "Device registered");
    } catch (e) {
      //await showAlert(message: e);
      print(e);
    }
  }
/*
  void deregisterButtonClicked() async {
    try {
      await notificationRegistrationService.deregisterDevice();
      await showAlert(message: "Device deregistered");
    } catch (e) {
      await showAlert(message: e);
    }
  }
*/
  Future<void> showAlert({message: String, BuildContext? context}) async {
    return showDialog<void>(
      context: this.context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Total Travel'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
      home: Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
                width: double.infinity,
                height: 100,
                margin: EdgeInsets.fromLTRB(0.0, 35.0, 1.0, 0.0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 101, 45, 144),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 250,
                      height: 100,
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(160, 5, 0, 5),
                        child: Image.asset(
                          'assets/images/logo-AHM-Fondo-Morao.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Flexible(
                        flex: 6,
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                //backgroundColor: MaterialStateProperty.all(Colors.red),
                                backgroundColor: MaterialStateProperty.all(
                                    HexColor('#652D90')),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login()));
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.account_circle,
                                    size: 18.0,
                                    color: white,
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    'Ingresar',
                                    style:
                                        TextStyle(color: white, fontSize: 18.0),
                                  )
                                ],
                              )),
                        )),
                  ],
                )),
            FutureBuilder<dynamic>(
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    height: 550,
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: 530,
                        // aspectRatio: 1.0,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                        autoPlay: true,
                      ),
                      items: LandScreenPackage(snapshot.data, context),
                    ),
                  );
                } else {
                  return Center(
                      child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 200, 0, 0),
                    child: CircularProgressIndicator(
                        color: Color.fromARGB(255, 101, 45, 144)),
                  ));
                }
              },
              future: GetListadoPackages(),
            ),
          ],
        ),
      ),
      )
    );
  }

  // Login Button
  @override
  Widget loginButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ButtonStyle(
          //backgroundColor: MaterialStateProperty.all(Colors.red),
          backgroundColor: MaterialStateProperty.all(HexColor('#652D90')),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        onPressed: () {},
        child: const Text('Ingresar'),
      ),
    );
  }
}
