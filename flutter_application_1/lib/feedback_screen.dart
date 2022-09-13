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
          children: [
                   ClipRect(
                        child: Container(
                          width: double.infinity,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Color(0xFF262D34),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: Image.asset(
                                'assets/images/userImage2.jpg',
                              ).image,
                            ),
                          ),
                        ),  
                    ),
                    Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
              Text('Honduras'),
              Text('Incluye: Tres tiempos de alimentacion, 3 Noches de alojamiento en un hotel ,Entradas a areas Protegidas, Rafting, Charla de introduccion,Traslado hasta lugar del rafting,Guias capacitados para las actividades.'),
            ],) 
            )   
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

  