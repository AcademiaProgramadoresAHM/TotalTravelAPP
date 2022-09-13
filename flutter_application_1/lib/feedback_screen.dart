import 'package:flutter_application_1/app_theme.dart';
import 'package:flutter/material.dart';


class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
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
          title: Text('           Paquetes predeterminados'),
          backgroundColor: Color.fromRGBO(101,45,143,1),
        ),
        body: ListView(
      children: <Widget>[
        Container(
          margin:EdgeInsets.all(8.0),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: InkWell(
              onTap: () => print("ciao"),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,  // add this
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                    ),
                    child: Image.asset(
                                'assets/images/Honduras.png',
                              )
                  ),
                  ListTile(
                    title: Text('Honduras'),
                    subtitle: Text('Incluye: Tres tiempos de alimentacion, 3 Noches de alojamiento en un hotel ,Entradas a areas Protegidas, Rafting, Charla de introduccion,Traslado hasta lugar del rafting,Guias capacitados para las actividades.'),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          margin:EdgeInsets.all(8.0),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: InkWell(
              onTap: () => print("ciao"),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                    ),
                    child: Image.asset(
                                'assets/images/Inglaterra.jpg',
                              )
                  ),
                  ListTile(
                    title: Text('Inglaterra'),
                    subtitle: Text('Incluye: Tres tiempos de alimentacion, 3 Noches de alojamiento en un hotel ,Entradas a areas Protegidas, Rafting, Charla de introduccion,Traslado hasta lugar del rafting,Guias capacitados para las actividades'),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          margin:EdgeInsets.all(8.0),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: InkWell(
              onTap: () => print("ciao"),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                    ),
                    child: Image.asset(
                                'assets/images/ElSalvador.jpg',
                              )
                  ),
                  ListTile(
                    title: Text('El Salvador'),
                    subtitle: Text('Incluye: Tres noches de alojamiento en hotel,Desayuno,Almuerzo, Cena estilo buffet incluido,Bebidas de la casa ilimitadas,Actividades de animacion en el dia y noche,Uso de las instalaciones.'),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          margin:EdgeInsets.all(8.0),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: InkWell(
              onTap: () => print("ciao"),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                    ),
                    child: Image.asset(
                                'assets/images/Zambia.jpg',
                              )
                  ),
                  ListTile(
                    title: Text('Zambia'),
                    subtitle: Text('Incluye: Tres noches de alojamiento en hotel,Desayuno,Almuerzo, Cena estilo buffet incluido,Bebidas de la casa ilimitadas,Actividades de animacion en el dia y noche,Uso de las instalaciones.'),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          margin:EdgeInsets.all(8.0),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: InkWell(
              onTap: () => print("ciao"),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                    ),
                    child: Image.asset(
                                'assets/images/Guatemala.jpg',
                              )
                  ),
                  ListTile(
                    title: Text('Guatemala'),
                    subtitle: Text('Incluye: Alojamiento 4 dias y tres noches,Alimentacion completa tipo buffet, Bebidas ilimitadas de todas las marcas,Fiesta en la playa y show de noche, Actividades de animacion de dia y de noche.'),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          margin:EdgeInsets.all(8.0),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: InkWell(
              onTap: () => print("ciao"),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                    ),
                    child:Image.asset(
                                'assets/images/Jamaica.jpg',
                              )
                  ),
                  ListTile(
                    title: Text('Jamaica'),
                    subtitle: Text('Incluye: Alojamiento 4 dias y tres noches,Alimentacion completa tipo buffet, Bebidas ilimitadas de todas las marcas,Fiesta en la playa y show de noche, Actividades de animacion de dia y de noche.'),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          margin:EdgeInsets.all(8.0),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: InkWell(
              onTap: () => print("ciao"),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                    ),
                    child: Image.asset(
                                'assets/images/Mexico4.jpg',
                              )
                  ),
                  ListTile(
                    title: Text('Mexico'),
                    subtitle: Text('Incluye: Tres noches y cautro dias de hospedaje,Coctel de bienvenidad, Desayuno gratuito diario,Caminata guiada por senderos,Visita guiada reserva natural, Uso libre de las instalaciones.'),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          margin:EdgeInsets.all(8.0),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: InkWell(
              onTap: () => print("ciao"),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                    ),
                    child:  Image.asset(
                                'assets/images/Marruecos.jpg',
                              )
                  ),
                  ListTile(
                    title: Text('Marruecos'),
                    subtitle: Text('Incluye: Tres noches y cautro dias de hospedaje,Coctel de bienvenidad, Desayuno gratuito diario,Caminata guiada por senderos,Visita guiada reserva natural, Uso libre de las instalaciones.'),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          margin:EdgeInsets.all(8.0),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: InkWell(
              onTap: () => print("ciao"),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                    ),
                    child:Image.asset(
                                'assets/images/Argentina.jpg',
                              )
                  ),
                  ListTile(
                    title: Text('Argentina'),
                    subtitle: Text('Incluye: Hospedaje maximo de 4 personas,Desayuno tipico, Coctel de bienvenidad,Caminata guiada,Dos noches de espectaculo Uso libre de las instalaciones,Uso libre del bar.'),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          margin:EdgeInsets.all(8.0),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: InkWell(
              onTap: () => print("ciao"),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                    ),
                    child: Image.asset(
                                'assets/images/Pakistan.jpg',
                              )
                  ),
                  ListTile(
                    title: Text('Pakistan'),
                    subtitle: Text('Incluye: Hospedaje maximo de 4 personas,Desayuno tipico, Coctel de bienvenidad,Caminata guiada,Dos noches de espectaculo Uso libre de las instalaciones,Uso libre del bar'),
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

  