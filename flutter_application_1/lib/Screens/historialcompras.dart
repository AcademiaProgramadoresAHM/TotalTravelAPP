import 'package:flutter_application_1/app_theme.dart';
import 'package:flutter/material.dart';

class Comprashistorial extends StatefulWidget {
  @override
  _ComprashistorialState createState() => _ComprashistorialState();
}

class _ComprashistorialState extends State<Comprashistorial> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter layout demo',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              title: Text('          Historial de Compras'),
              backgroundColor: Color.fromRGBO(101, 45, 143, 1),
            ),
            body: ListView(
              children: <Widget>[
                miCard(),
                miCardImage(),
                miCardDesign(),
                miCardImage2(),
                miCardDesignn(),
                miCardImage3(),
              ],
            )));
  }

  Card miCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(15),
      elevation: 10,
      color: Color(0xFFE6EE9C),
      child: Column(
        children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
            title: Text('Hotel La Encenada'),
            subtitle: Text(
                ' Cuatro dias y tres noches con todo incluido y con uso libre de las instalaciones ademas de barra libre. L0.00'),
            leading: Icon(Icons.home),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[],
          )
        ],
      ),
    );
  }

  Card miCardImage() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(15),
      elevation: 10,
      child: Column(
        children: <Widget>[
          Image(
            image: NetworkImage(
                'https://media-cdn.tripadvisor.com/media/photo-s/15/19/a9/67/disfruta-de-nuestra-piscina.jpg'),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text('Detalles'),
          ),
        ],
      ),
    );
  }

  Card miCardDesign() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(15),
      elevation: 10,
      color: Color(0xFFE6EE9C),
      child: Column(
        children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
            title: Text('Paquete Inglaterra'),
            subtitle: Text(
                'Con hospedaje en el  Hotel Hilton Princess, uso libre de todas  sus intalaciones y diversas actividades. L0.00 '),
            leading: Icon(Icons.home),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[],
          )
        ],
      ),
    );
  }

  Card miCardImage2() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(15),
      elevation: 10,
      child: Column(
        children: <Widget>[
          Image(
            image: NetworkImage(
                'https://www.caracteristicas.co/wp-content/uploads/2018/09/Inglaterra-1-e1579225426978-800x416.jpg'),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text('Detalles'),
          ),
        ],
      ),
    );
  }
}

Card miCardDesignn() {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    margin: EdgeInsets.all(15),
    elevation: 10,
    color: Color(0xFFE6EE9C),
    child: Column(
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
          title: Text('Nadar con tiburones'),
          subtitle: Text(
              'VivE una experiencia inolvidable nadando entre tiburones ballena, los peces más grandes del mundo. Practicaremos snorkel en el Caribe y disfrutaremos de una comida en las aguas de Playa Norte. L.0.00'),
          leading: Icon(Icons.home),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[],
        )
      ],
    ),
  );
}

Card miCardImage3() {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    margin: EdgeInsets.all(15),
    elevation: 10,
    child: Column(
      children: <Widget>[
        Image(
          image: NetworkImage(
              'https://topbuceo.net/wp-content/uploads/2020/03/consejos-bucear-con-tiburones.jpg'),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Text('Detalles'),
        ),
      ],
    ),
  );
}
