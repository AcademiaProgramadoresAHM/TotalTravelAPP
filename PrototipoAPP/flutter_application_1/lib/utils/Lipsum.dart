import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/models.dart';
import '../utils/AppWidget.dart';
import '../utils/T2Colors.dart';
import '../utils/T2DataGenerator.dart';
import '../utils/T2Strings.dart';

class Trans extends StatefulWidget {
  static var tag = "/DemoT2Cards";

  @override
  Transpor createState() => Transpor();
}

class Transpor extends State<Trans> {
  late List<T2Favourite> mFavouriteList;

  @override
  void initState() {
    super.initState();
    mFavouriteList = getFavourites();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    changeStatusColor(appStore.appBarColor);
    return MaterialApp(
      title: 'Flutter layout demo',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('           Actividades'),
          backgroundColor: Color.fromRGBO(101, 45, 143, 1),
        ),
        body: Observer(
          builder: (_) => Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.only(top: 16, bottom: 16),
                  itemCount: mFavouriteList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: Container(
                        margin:
                            EdgeInsets.only(left: 16, right: 16, bottom: 16),
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
                                            CachedNetworkImage(
                                              placeholder: (context, url) =>
                                                  placeholderWidget(),
                                              imageUrl:
                                                  mFavouriteList[index].image,
                                              width: width / 5,
                                              height: 100,
                                            ),
                                            Expanded(
                                              child: Container(
                                                padding:
                                                    EdgeInsets.only(left: 16),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                        mFavouriteList[index]
                                                            .name,
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
                                                                .textSecondaryColor)),
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
                                                color: appStore
                                                    .textSecondaryColor),
                                            maxLines: 2),
                                        Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Expanded(
                                                  flex: 3,
                                                  child: ElevatedButton(
                                                      child: Text('Ver detalles',
                                                        style: TextStyle(fontSize: 14)),
                                                      style: ElevatedButton.styleFrom(
                                                        primary: Color.fromARGB(255, 101, 45, 143),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(builder: (context) => Trans()),
                                                        );
                                                      },
                                                  ),
                                                ),
                                                Expanded(child: Text(''),),
                                                Expanded(
                                                  flex: 3,
                                                  child: ElevatedButton(
                                                      child: Text('Reservar',
                                                        style: TextStyle(fontSize: 14)),
                                                      style: ElevatedButton.styleFrom(
                                                        primary: Color.fromARGB(255, 101, 45, 143),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(builder: (context) => Trans()),
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
        ),
      ),
    );
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}