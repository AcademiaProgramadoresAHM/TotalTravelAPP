import '../utils/models.dart';
import 'T2Images.dart';

List<Restaurantes> getRestaurantes() {
  List<Restaurantes> list = [];
  Restaurantes model1 = Restaurantes();
  model1.name = "Lupitas";
  model1.descripcion = "Lupitas es su casa lejos de casa, aquí el trabajo o placer cumplirán con todas sus expectativas.";
  model1.image = t2_rest_img1;
  model1.puntuacion = 5;

  Restaurantes model2 = Restaurantes();
  model2.name = "Factory steak and lobster";
  model2.descripcion = "Factory steak and lobster se encuentra en San Pedro Sula y tiene solárium con piscina y bar. Recepción 24 horas, y WiFi gratuita en todas las zonas.";
  model2.image = t2_rest_img2;
  model2.puntuacion = 3;

  Restaurantes model3 = Restaurantes();
  model3.name = "The Market";
  model3.descripcion = "Bienvenido al The Market San Pedro Sula, Honduras. Ubicado en el centro de la capital industrial del país, junto a la zona de centros corporativos más importantes y atracciones.";
  model3.image = t2_rest_img3;
  model3.puntuacion = 4;

  list.add(model1);
  list.add(model2);
  list.add(model3);
  return list;
}