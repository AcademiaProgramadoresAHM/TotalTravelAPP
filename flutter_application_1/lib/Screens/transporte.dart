import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/Login.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/prueba2/AppWidget.dart';
import '../utils/prueba2/T2Colors.dart';
import '../utils/prueba2/T2Strings.dart';
import '../utils/prueba2/model.dart';
import '../utils/prueba2/T2DataGene.dart';

const Color _colorOne = Color(0x33000000);
const Color _colorTwo = Color(0x24000000);
const Color _colorThree = Color(0x1F000000);

/*void main() {
  runApp(new CupertinoSegmentedControlDemo());
}*/

class transporte extends StatefulWidget {
  @override
  _transporteState createState() => _transporteState();
}

class _transporteState extends State<transporte> {
  late List<T2Favourite> mFavouriteList;
  @override
  void initState() {
    super.initState();
    mFavouriteList = getFavourites();
  }

  final Map<int, Widget> logoWidgets = const <int, Widget>{
    0: Text('Terrestre'),
    1: Text('Marítimo'),
    2: Text('Aéreo'),
  };

  final Map<int, Widget> icons = <int, Widget>{
    0: Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.only(top: 16, bottom: 16),
            //itemCount: mFavouriteList.length,
            itemBuilder: (context, index) {
              return Container(
                child: Container(
                  margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  decoration: BoxDecoration(
                      boxShadow: defaultBoxShadow(),
                      borderRadius: BorderRadius.circular(12)),
                  child: IntrinsicHeight(
                    child: Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      color: context.scaffoldBackgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(color: t2_colorPrimary, width: 10),
                          SizedBox(width: 10),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      /*CachedNetworkImage(
                                        placeholder: (context, url) =>
                                            placeholderWidget(),
                                        imageUrl: mFavouriteList[index].image,
                                        width: width / 5,
                                        height: 100,
                                      ),*/
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.only(left: 16),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              /*Text(mFavouriteList[index].name,
                                                  style: boldTextStyle(
                                                      color: appStore
                                                          .textPrimaryColor),
                                                  maxLines: 2),
                                              Text(
                                                  mFavouriteList[index]
                                                      .duration,
                                                  style: primaryTextStyle(
                                                      size: 16,
                                                      color: appStore
                                                          .textSecondaryColor)),*/
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 16),
                                  Text(t2_samplelong_text,
                                      style: primaryTextStyle(
                                          size: 16,
                                          color: appStore.textSecondaryColor),
                                      maxLines: 2),
                                  Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            flex: 3,
                                            child: ElevatedButton(
                                              child: Text('Ver detalles',
                                                  style:
                                                      TextStyle(fontSize: 14)),
                                              style: ElevatedButton.styleFrom(
                                                primary: Color.fromARGB(
                                                    255, 101, 45, 143),
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Login()),
                                                );
                                              },
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(''),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: ElevatedButton(
                                              child: Text('Reservar',
                                                  style:
                                                      TextStyle(fontSize: 14)),
                                              style: ElevatedButton.styleFrom(
                                                primary: Color.fromARGB(
                                                    255, 101, 45, 143),
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Login()),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ],
    ),
    1: Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.only(top: 16, bottom: 16),
            //itemCount: mFavouriteList.length,
            itemBuilder: (context, index) {
              return Container(
                child: Container(
                  margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  decoration: BoxDecoration(
                      boxShadow: defaultBoxShadow(),
                      borderRadius: BorderRadius.circular(12)),
                  child: IntrinsicHeight(
                    child: Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      color: context.scaffoldBackgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(color: t2_colorPrimary, width: 10),
                          SizedBox(width: 10),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      /*CachedNetworkImage(
                                        placeholder: (context, url) =>
                                            placeholderWidget(),
                                        imageUrl: mFavouriteList[index].image,
                                        width: width / 5,
                                        height: 100,
                                      ),*/
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.only(left: 16),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              /*Text(mFavouriteList[index].name,
                                                  style: boldTextStyle(
                                                      color: appStore
                                                          .textPrimaryColor),
                                                  maxLines: 2),
                                              Text(
                                                  mFavouriteList[index]
                                                      .duration,
                                                  style: primaryTextStyle(
                                                      size: 16,
                                                      color: appStore
                                                          .textSecondaryColor)),*/
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 16),
                                  Text(t2_samplelong_text,
                                      style: primaryTextStyle(
                                          size: 16,
                                          color: appStore.textSecondaryColor),
                                      maxLines: 2),
                                  Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            flex: 3,
                                            child: ElevatedButton(
                                              child: Text('Ver detalles=',
                                                  style:
                                                      TextStyle(fontSize: 14)),
                                              style: ElevatedButton.styleFrom(
                                                primary: Color.fromARGB(
                                                    255, 101, 45, 143),
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Login()),
                                                );
                                              },
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(''),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: ElevatedButton(
                                              child: Text('Reservar=',
                                                  style:
                                                      TextStyle(fontSize: 14)),
                                              style: ElevatedButton.styleFrom(
                                                primary: Color.fromARGB(
                                                    255, 101, 45, 143),
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Login()),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ],
    ),
    2: Center(
      child: Card(
        child: InkWell(
          splashColor: Colors.cyan,
          onTap: () {
            debugPrint('Card tapped3.');
          },
          child: const SizedBox(
            width: 300,
            height: 100,
            child: Text('A card that can be tapped1'),
          ),
        ),
      ),
    ),
  };

  int sharedValue = 0;

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: AppBar(
          title: Text('           Transportes'),
          backgroundColor: Color.fromRGBO(101, 45, 143, 1),
        ),
        body: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(16.0),
            ),
            SizedBox(
              width: 500.0,
              child: CupertinoSegmentedControl<int>(
                children: logoWidgets,
                onValueChanged: (int val) {
                  setState(() {
                    sharedValue = val;
                  });
                },
                groupValue: sharedValue,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 32.0,
                  horizontal: 16.0,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 64.0,
                    horizontal: 16.0,
                  ),
                  decoration: BoxDecoration(
                    color: CupertinoColors.white,
                    borderRadius: BorderRadius.circular(3.0),
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                        offset: Offset(0.0, 3.0),
                        blurRadius: 5.0,
                        spreadRadius: -1.0,
                        color: _colorOne,
                      ),
                      BoxShadow(
                        offset: Offset(0.0, 6.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.0,
                        color: _colorTwo,
                      ),
                      BoxShadow(
                        offset: Offset(0.0, 1.0),
                        blurRadius: 18.0,
                        spreadRadius: 0.0,
                        color: _colorThree,
                      ),
                    ],
                  ),
                  child: icons[sharedValue],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
