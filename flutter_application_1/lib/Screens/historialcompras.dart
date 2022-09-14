import 'package:flutter_application_1/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/detallesdehistorial.dart';

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
          title: Text('           Historial de Compras'),
          backgroundColor: Color.fromRGBO(101, 45, 143, 1),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                child: InkWell(
                  onTap: () => print("ciao"),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch, // add this
                    children: <Widget>[
                      ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0),
                          ),
                          child: Image.asset(
                            'assets/images/Inglaterra.jpg',
                          )),
                      ListTile(
                        title: Text('Paquete Inglaterra'),
                        subtitle: Text('Hotel: Hilton Princess '),
                        trailing: Text('L.45900.00',
                            style:
                                TextStyle(color: Colors.green, fontSize: 20)),
                      ),
                      TextButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => detalleshistorial()),
                          );
                        },
                        child: Text('Ver Detalles'),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                child: InkWell(
                  onTap: () => print("ciao"),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch, // add this
                    children: <Widget>[
                      ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0),
                          ),
                          child: Image.asset(
                            'assets/images/Jamaica.jpg',
                          )),
                      ListTile(
                        title: Text('Paquete Jamaica'),
                        subtitle: Text('Hotel: Hilton Princess'),
                        trailing: Text('L.15000.00',
                            style:
                                TextStyle(color: Colors.green, fontSize: 20)),
                      ),
                      TextButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => detalleshistorial()),
                          );
                        },
                        child: Text('Ver Detalles'),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                child: InkWell(
                  onTap: () => print("ciao"),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch, // add this
                    children: <Widget>[
                      ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0),
                          ),
                          child: Image.asset(
                            'assets/images/hotel.jpg',
                          )),
                      ListTile(
                        title: Text('La Ensenada'),
                        subtitle: Text('Hotel: La Ensenada  4dias/3noches'),
                        trailing: Text('L.4900.00',
                            style:
                                TextStyle(color: Colors.green, fontSize: 20)),
                      ),
                      TextButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => detalleshistorial()),
                          );
                        },
                        child: Text('Ver Detalles'),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                child: InkWell(
                  onTap: () => print("ciao"),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch, // add this
                    children: <Widget>[
                      ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0),
                          ),
                          child: Image.asset(
                            'assets/images/Zambia.jpg',
                          )),
                      ListTile(
                        title: Text('Paquete Zambia'),
                        subtitle: Text('Hotel: Pepitos Intercontinental '),
                        trailing: Text('L.50900.00',
                            style:
                                TextStyle(color: Colors.green, fontSize: 20)),
                      ),
                      TextButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => detalleshistorial()),
                          );
                        },
                        child: Text('Ver Detalles'),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
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
