import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/AppWidget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_application_1/Components/Packages.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_application_1/hotel_booking/hotel_app_theme.dart';
import 'package:flutter_application_1/hotel_booking/model/PlanModal.dart';
import 'package:flutter_application_1/Screens/Login.dart';
import 'package:flutter_application_1/Screens/signUp_view.dart';

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
    List<PlanModal> PlanList = [];
    List<Container> list = [];
    final _controller = PageController();
    data.forEach((element) {
      PlanList.add(
        PlanModal(
          image: 'assets/images/Argentina.jpg',
          title: element['nombre'],
          subTitle: element['descripcion_Paquete'],
          price: '\$' + element['Precio'],
          planPriceSubTitle: 'per user/month',
          optionList: [
            PlanModal(title: element['hotel']),
            PlanModal(title: element['restaurante']),
            PlanModal(title: 'Hoteles 5 Estrellas'),
          ],
        ),
      );
      list.add(
        Container(
          height: 650,
          width: context.width(),
          child: Container(
            height: 650,
            child: Container(
              // margin: EdgeInsets.symmetric(
              //     vertical: pageIndex == index ? 16 : 50, horizontal: 8),
              // height: pageIndex == index ? 0.5 : 0.45,
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
                        Text(element['nombre'], style: boldTextStyle(size: 30)),
                        Text(element['descripcion_Paquete'],
                            style: secondaryTextStyle()),
                        24.height,
                        Text('\$0',
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
                                Text(element['hotel'],
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                                Text(element['restaurante'],
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                                Text(element['duracion_Paquete'],
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
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    planList.add(
      PlanModal(
        image: 'assets/images/Argentina.jpg',
        title: 'Basico',
        subTitle: 'Disfruta de un experiencia inolvidable',
        price: '\$0',
        planPriceSubTitle: 'per user/month',
        optionList: [
          PlanModal(title: 'Viaja hazta con 3 personas mas'),
          PlanModal(title: 'Transporte hacia tu destino'),
          PlanModal(title: 'Hoteles 5 Estrellas'),
        ],
      ),
    );
    planList.add(
      PlanModal(
        image: 'assets/images/Argentina.jpg',
        title: 'Standard',
        subTitle: 'For Small and medium business',
        price: '\$15',
        planPriceSubTitle: 'per user/month',
        optionList: [
          PlanModal(title: 'Up to 20 users'),
          PlanModal(title: 'Up to 200 transaction per month'),
          PlanModal(title: 'Single Company record'),
        ],
        isVisible: true,
      ),
    );
    planList.add(
      PlanModal(
        image: 'assets/images/Argentina.jpg',
        title: 'Enterprise',
        subTitle: 'Solution for big organization',
        price: '\$20',
        planPriceSubTitle: 'per user / month',
        optionList: [
          PlanModal(title: 'Unlimited users'),
          PlanModal(title: 'Unlimited transaction'),
          PlanModal(title: 'Multiple Company record'),
        ],
      ),
    );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: Image.asset(
                'assets/images/AHM-Fondo-Nombre.png',
                fit: BoxFit.contain,
              ),
            ),
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
                  return Text("No data");
                }
              },
              future: GetListadoPackages(),
            ),
            Container(
              width: 330,
              height: 55,
              child: ElevatedButton(
                style: ButtonStyle(
                  //backgroundColor: MaterialStateProperty.all(Colors.red),
                  backgroundColor:
                      MaterialStateProperty.all(HexColor('#652D90')),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                },
                child: const Text('Ingresar', style: TextStyle(fontSize: 20)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 330,
              height: 55,
              child: ElevatedButton(
                style: ButtonStyle(
                  //backgroundColor: MaterialStateProperty.all(Colors.red),
                  backgroundColor:
                      MaterialStateProperty.all(HexColor('#652D90')),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUpView()));
                },
                child:
                    const Text('Registrarse', style: TextStyle(fontSize: 20)),
              ),
            ),
          ],
        ),
      ),
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
