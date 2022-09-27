import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/models.dart';
import '../utils/AppWidget.dart';
import '../utils/T2Colors.dart';
import '../utils/ListaRestaurantes.dart';
import '../utils/flutter_rating_bar.dart';

class restaurante extends StatefulWidget {
  static var tag = "/DemoT2Cards";

  @override
  RestauranteState createState() => RestauranteState();
}

class RestauranteState extends State<restaurante> {
  late List<Restaurantes> ListaRestaurantes;

  @override
  void initState() {
    super.initState();
    ListaRestaurantes = getRestaurantes();
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
          title: Text('           Restaurantes'),
          backgroundColor: Color.fromRGBO(101, 45, 143, 1),
        ),
        body: Observer(
          builder: (_) => Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.only(top: 16, bottom: 16),
                  itemCount: ListaRestaurantes.length,
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
                                                  ListaRestaurantes[index].image,
                                              width: 150,
                                              height: 100,
                                            ),
                                            Expanded(
                                              flex: 3,
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
                                                        ListaRestaurantes[index]
                                                            .name,
                                                        style: boldTextStyle(
                                                            color: appStore
                                                                .textPrimaryColor),
                                                        maxLines: 2),
                                                    /*Text(
                                                        mFavouriteList[index]
                                                            .descripcion,
                                                        style: primaryTextStyle(
                                                            size: 16,
                                                            color: appStore
                                                                .textSecondaryColor)),*/
                                                    
                                                    RatingBarIndicator(
                                                      rating: (ListaRestaurantes[index].puntuacion).toDouble(),
                                                      itemSize: 16,
                                                      direction: Axis.horizontal,
                                                      itemPadding:
                                                          EdgeInsets.symmetric(horizontal: 1.0),
                                                      itemBuilder: (context, _) => Icon(
                                                        Icons.star,
                                                        color: appStore.textPrimaryColor,
                                                      ),
                                                      
                                                    ),
                                                  ],
                                                  
                                                ),
                                              ),
                                            )
                                          ],
                                          
                                        ),
                                        SizedBox(height: 16),
                                        Text(ListaRestaurantes[index]
                                                            .descripcion,
                                            style: primaryTextStyle(
                                                size: 16,
                                                color: appStore
                                                    .textSecondaryColor),
                                            ),
                                        Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Expanded(
                                                  flex: 3,
                                                  child: ElevatedButton(
                                                      child: Text('Ver menú',
                                                        style: TextStyle(fontSize: 14)),
                                                      style: ElevatedButton.styleFrom(
                                                        primary: Color.fromARGB(255, 101, 45, 143),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(builder: (context) => restaurante()),
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
                                                          MaterialPageRoute(builder: (context) => restaurante()),
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
