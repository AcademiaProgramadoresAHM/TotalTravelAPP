import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_application_1/Components/Packages.dart';
import 'package:intl/intl.dart';
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
          price: '\$0',
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
          height: 600,
          width: context.width(),
          child: PageView.builder(
            controller: controller,
            itemCount: PlanList.length,
            onPageChanged: (index) {
              pageIndex = index;
              setState(() {});
            },
            itemBuilder: (_, int index) {
              bool isPageIndex = selectedIndex == index;

              return AnimatedContainer(
                margin: EdgeInsets.symmetric(
                    vertical: pageIndex == index ? 16 : 50, horizontal: 8),
                height: pageIndex == index ? 0.5 : 0.45,
                width: context.width(),
                decoration: BoxDecoration(
                  color: context.cardColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: defaultBoxShadow(),
                ),
                duration: 1000.milliseconds,
                curve: Curves.linearToEaseOut,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      planList[index].image.validate(),
                      fit: BoxFit.cover,
                      height: 190,
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(PlanList[index].title.validate(),
                              style: boldTextStyle(size: 30)),
                          Text(PlanList[index].subTitle.validate(),
                              style: secondaryTextStyle()),
                          24.height,
                          Text(PlanList[index].price.validate(),
                              style: boldTextStyle(
                                  size: 45, color: blueButtonAndTextColor)),
                          Text(PlanList[index].planPriceSubTitle.validate(),
                              style: secondaryTextStyle()),
                          24.height,
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: UL(
                              symbolType: SymbolType.Bullet,
                              symbolColor: Color.fromARGB(255, 101, 45, 144),
                              spacing: 24,
                              children: List.generate(
                                PlanList[index].optionList!.length,
                                (i) => Text(
                                    PlanList[index]
                                        .optionList![i]
                                        .title
                                        .validate(),
                                    style: boldTextStyle()),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ).expand(),
                    AppButton(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      width: context.width() - 120,
                      child: TextIcon(
                        prefix: isPageIndex
                            ? Icon(Icons.check,
                                color: selectedIndex == index
                                    ? Colors.green
                                    : null,
                                size: 16)
                            : null,
                        text: isPageIndex ? 'Adquirir' : 'Upgrade',
                        textStyle: boldTextStyle(
                            size: 18,
                            color: isPageIndex ? Colors.green : white),
                      ),
                      onTap: () {
                        setState(() {});
                        selectedIndex = index;
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      shapeBorder: RoundedRectangleBorder(
                          borderRadius: radius(defaultRadius)),
                      color: isPageIndex
                          ? Colors.green.shade100
                          : blueButtonAndTextColor,
                    ).paddingBottom(16),
                  ],
                ),
              );
            },
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
      body: Container(
        child: Column(
          children: <Widget>[
            FutureBuilder<dynamic>(
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      direction: Axis.horizontal,
                      runAlignment: WrapAlignment.start,
                      verticalDirection: VerticalDirection.down,
                      clipBehavior: Clip.none,
                      children: LandScreenPackage(snapshot.data, context));
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
