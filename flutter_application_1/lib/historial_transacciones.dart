import 'package:flutter_application_1/app_theme.dart';
import 'package:flutter/material.dart';

class HistorialScreen extends StatefulWidget {
  @override
  _HistorialScreenState createState() => _HistorialScreenState();
}

class _HistorialScreenState extends State<HistorialScreen> {
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
          title: Text('           Historial de Transacciones'),
          backgroundColor: Color.fromRGBO(101, 45, 143, 1),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                child: InkWell(
                  onTap: () => print("ciao"),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch, // add this
                    children: <Widget>[
                      ListTile(
                        title: Text('Codigo De Factura'),
                        subtitle: Text('#098213'),
                      ),
                      ListTile(
                        title: Text('Fecha de compra'),
                        subtitle: Text('20/04/2022'),
                      ),
                      ListTile(
                        title: Text('Nombre del paquete'),
                        subtitle: Text('Paquete Personalizado: HN-GT'),
                      ),
                      ListTile(
                        title: Text('Total'),
                        subtitle: Text('L 25,000'),
                      ),
                      ListTile(
                        title: Text('Tipo Pago'),
                        subtitle: Text('Tranferencia Bancaria'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                child: InkWell(
                  onTap: () => print("ciao"),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      ListTile(
                        title: Text('Codigo De Factura'),
                        subtitle: Text('#90832'),
                      ),
                      ListTile(
                        title: Text('Fecha de compra'),
                        subtitle: Text('20/10/2022'),
                      ),
                      ListTile(
                        title: Text('Nombre del paquete'),
                        subtitle: Text('Viaje Por Roatan'),
                      ),
                      ListTile(
                        title: Text('Total'),
                        subtitle: Text('L 13,000'),
                      ),
                      ListTile(
                        title: Text('Tipo Pago'),
                        subtitle: Text('Tarjeta de Credito'),
                      ),
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
