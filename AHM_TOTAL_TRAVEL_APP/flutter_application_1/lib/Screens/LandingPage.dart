import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:flutter_application_1/hotel_booking/model/PlanModal.dart';
import 'package:flutter_application_1/Screens/Login.dart';

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

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    planList.add(
      PlanModal(
        image: 'assets/images/Argentina.jpg',
        title: 'Basic',
        subTitle: 'A Simplest Start to everyone',
        price: '\$0',
        planPriceSubTitle: 'per user/month',
        optionList: [
          PlanModal(title: 'Up to 5 users'),
          PlanModal(title: 'Up to 20 transaction per month'),
          PlanModal(title: 'Single Company record'),
        ],
      ),
    );
    planList.add(
      PlanModal(
        image: 'assets/images/Argentina.jpg',
        title: 'Standard',
        subTitle: 'For Small and medium business',
        price: '\$10',
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
        price: '\$18',
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
      appBar: appBarWidget(
        'Pricing plan 3',
        center: true,
        color: context.scaffoldBackgroundColor,
      ),
      backgroundColor: context.scaffoldBackgroundColor,
      body: Container(
        height: context.height(),
        width: context.width(),
        child: PageView.builder(
          controller: controller,
          itemCount: planList.length,
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
                        Text(planList[index].title.validate(),
                            style: boldTextStyle(size: 30)),
                        Text(planList[index].subTitle.validate(),
                            style: secondaryTextStyle()),
                        24.height,
                        Text(planList[index].price.validate(),
                            style: boldTextStyle(
                                size: 45, color: blueButtonAndTextColor)),
                        Text(planList[index].planPriceSubTitle.validate(),
                            style: secondaryTextStyle()),
                        24.height,
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: UL(
                            symbolType: SymbolType.Bullet,
                            symbolColor: Color.fromARGB(255, 101, 45, 144),
                            spacing: 24,
                            children: List.generate(
                              planList[index].optionList!.length,
                              (i) => Text(
                                  planList[index]
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
                              color:
                                  selectedIndex == index ? Colors.green : null,
                              size: 16)
                          : null,
                      text: isPageIndex ? ' Accediendo a compra' : 'Upgrade',
                      textStyle: boldTextStyle(
                          size: 18, color: isPageIndex ? Colors.green : white),
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
  }
}
