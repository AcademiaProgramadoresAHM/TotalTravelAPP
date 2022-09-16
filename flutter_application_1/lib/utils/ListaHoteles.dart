import '../utils/models.dart';
import 'T2Images.dart';

List<Hoteles> getHoteles() {
  List<Hoteles> list = [];
  Hoteles model1 = Hoteles();
  model1.name = "La Ensenada";
  model1.descripcion = "Aquí sus viajes de trabajo o placer cumplirán con todas sus expectativas.";
  model1.image = t2_rest_img1;
  model1.puntuacion = 5;

  Hoteles model2 = Hoteles();
  model2.name = "Hyatt Place";
  model2.descripcion = "Hay restaurante, recepción 24 horas, servicio de habitaciones y WiFi gratuita en todas las zonas.";
  model2.image = t2_rest_img2;
  model2.puntuacion = 4;

  Hoteles model3 = Hoteles();
  model3.name = "Hilton Princess SPS";
  model3.descripcion = "Ubicado en el centro de la capital industrial del país, junto a la zona de centros corporativos más importantes y atracciones.";
  model3.image = t2_rest_img3;
  model3.puntuacion = 4;

  list.add(model1);
  list.add(model2);
  list.add(model3);
  return list;
}